// NOTE 2016-08-05: Since Swift Package Manager isn't yet working, I just manually copied this file from: https://github.com/masonmark/mason.swift
// Someday, once the infrastructure is working and convenient, we can change this to properly depend on that package.

//　TaskWrapper.swift　Created by mason on 2016-03-19.　Copyright © 2016 MASONMARK.COM. All rights reserved.


#if os(OSX)

import Foundation


/// A convenience struct containing the results of running a task.

public struct TaskResult {
    public let stdoutText: String
    public let stderrText: String
    public let terminationStatus: Int
    
    public var combinedOutput: String {
        return stdoutText + stderrText
    }
}


/// A simple wrapper for NSTask, to synchronously run external commands. 
///
/// **Note:** The API provided by NSTask is pretty shitty, and inherently dangerous in Swift. There are many cases where it will throw Objective-C exceptions in response to ordinary, predictable error situations, and this will either crash the program, or at least un-catchably intterup execution and create undefined behavior, unless the program implements some kind of [legacy exception-handling mechanism](https://github.com/masonmark/CatchObjCException#catchobjcexception) (which can only be done in Objective-C, not Swift, at least as of this writing on 2016-03-19).
///
/// A non-exhaustive list:
/// - providing a bogus path for `launchPath`
/// - setting the `cwd` property to a path that doesn't point to a directory
/// - calling `launch()` more than once
/// - reading `terminationStatus` before the task has actually terminated
/// 
/// Protecting aginst all this fuckery is beyond the scope of this class (and this lifetime), so... be careful! (And complain to Apple.)
    
public class TaskWrapper: CustomStringConvertible {
    public var launchPath          =  "/bin/ls"
    public var cwd: String?        = nil
    public var arguments: [String] = []
    public var stdoutData          = NSMutableData()
    public var stderrData          = NSMutableData()

    public var stdoutText: String {
        if let text = String(data: stdoutData as Data, encoding: .utf8) {
            return text
        } else {
            return ""
        }
    }
    
    public var stderrText: String {
        if let text = String(data: stderrData as Data, encoding: .utf8) {
            return text
        } else {
            return ""
        }
    }
    
    var task = Foundation.Task()
    
    
    /// The required initialize does nothing, so you must set up all the instance's values yourself.
    
    public required init() {
        // this exists just to satisfy the swift compiler
    }
    
    
    /// This convenience initializer is for when you want to construct a task instance and keep it around.
    
    public convenience init(_ launchPath: String, arguments: [String] = [], directory: String? = nil, launch: Bool = true) {
        self.init()
        
        self.launchPath = launchPath
        self.arguments  = arguments
        self.cwd        = directory
        if launch {
            self.launch()
        }
    }
    

    /// This convenience method is for when you just want to run an external command and get the results back. Use it like this:
    ///
    ///     let results = TaskWrapper.run("ping", arguments: ["-c", "10", "masonmark.com"])
    ///     print(results.stdoutText)

    public static func run (_ launchPath: String, arguments: [String] = [], directory: String? = nil) -> TaskResult {
        let t = self.init()
        // Can't use convenience init because: "Constructing an object... with a metatype value must use a 'required' initializer."
        
        t.launchPath = launchPath
        t.arguments  = arguments
        t.cwd        = directory
        t.launch()
        
        return TaskResult(stdoutText: t.stdoutText, stderrText: t.stderrText, terminationStatus: t.terminationStatus)
    }
    
    
    /// Synchronously launch the underlying NSTask and wait for it to exit.
    
    public func launch() {
        task = Foundation.Task()
        
        if let cwd = cwd {
            task.currentDirectoryPath = cwd
        }
        
        task.launchPath     = launchPath
        task.arguments      = arguments
        
        let stdoutPipe      = Pipe()
        let stderrPipe      = Pipe()
        
        task.standardOutput = stdoutPipe
        task.standardError  = stderrPipe
        
        let stdoutHandle    = stdoutPipe.fileHandleForReading
        let stderrHandle    = stderrPipe.fileHandleForReading
        
        // WAS:         let dataReadQueue   = dispatch_queue_create("com.masonmark.Mason.swift.Task.readQueue", DISPATCH_QUEUE_SERIAL)
        
        let dataReadQueue   = DispatchQueue(label: "com.masonmark.Mason.swift.TaskWrapper.readQueue", qos: .default) // .serial, dropped between Swift 3b3 and b4?
        
        stdoutHandle.readabilityHandler = { [unowned self] (fh) in
            dataReadQueue.sync {
                let data = fh.availableData
                self.stdoutData.append(data)
            }
        }
        
        stderrHandle.readabilityHandler = { [unowned self] (fh) in
            dataReadQueue.sync {
                let data = fh.availableData
                self.stderrData.append(data)
            }
        }
        
        // Mason 2016-03-19: The handlers above get invoked on their own threads. At first, since we just block this
        // thread in a usleep loop until finished, I thought it was OK not to have any locking/synchronization around the
        // reading data and appending it to stdoutText and stderrText. But in the debugger, I verified that there is
        // sometimes a last read necessary after task.running returns false. This theoretically means that there could be
        // a race condition where the last readability handler was just starting to execute in a different thread, while
        // execution in this thread moved into the final read-filehandle-and-append-data operation. So now those reads
        // and writes are all wrapped in dispatch_sync() and execute on the serial queue created above.
        
        task.launch()
        
        while task.isRunning {
            // If you don't read here, buffers can fill up with a lot of output (> 8K?), and deadlock, where the normal
            // read methods block forever. But the readabilityHandler blocks we attached above will handle it, so here
            // we just wait for the task to end.
            usleep(100000)
        }
        
        stdoutHandle.readabilityHandler = nil
        stderrHandle.readabilityHandler = nil
        
        // Mason 2016-03-19: Just confirmed in debugger that there may still be data waiting in the buffers; readabilityHandler apparently not guaranteed to exhaust data before NSTask exits running state. So:
        
        dataReadQueue.sync {
            self.stdoutData.append(stdoutHandle.readDataToEndOfFile())
            self.stderrData.append(stderrHandle.readDataToEndOfFile())
        }
    }
    
    
    /// Returns the underlying NSTask instance's `terminationStatus`. Note: NSTask will raise an Objective-C exception if you call this before the task has actually terminated.
    
    public var terminationStatus: Int {
        return Int(task.terminationStatus)
    }
    
    
    public var description: String {
        var result = ">>++++++++++++++++++++++++++++++++++++++++++++++++++++>>\n"
        result    += "COMMAND: \(launchPath) \(arguments.joined(separator: " "))\n"
        result    += "TERMINATION STATUS: \(terminationStatus)\n"
        result    += "STDOUT: \(stdoutText)\n"
        result    += "STDERR: \(stderrText)\n"
        result    += "<<++++++++++++++++++++++++++++++++++++++++++++++++++++<<"
        
        return result
    }
    
}

#endif // #if os(OSX)
