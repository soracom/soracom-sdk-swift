// APIOperation.swift Created by mason on 2016-04-23. Copyright © 2016 masonmark.com. All rights reserved.

import Foundation


/// The APIOperation class makes it easy to use Request instances with NSOperationQueue. The semantics are
/// similar to Request's `run(_:)` method. The normal way to use APIOperation is to take advantage of the
/// extension to NSOperationQueue that allows you to add a request directly to a queue:
///
///     let createOperator = Request.createOperator(emailAddress, password: password)
///
///     queue.addRequest(createOperator) { (response) in
///
///         // do something with response...
///     }
///
/// That will automatically create an APIOperation instance from the request, and add that operation to the
/// queue. However, you can also directly instantiate an APIOperation instance and add it to a queue:
///
///     let op = APIOperation(request) {  (response) in
///          
///         // do something with response...
///      }
///
/// The second more verbose form is mainly for if you are doing something more complicated with the 
/// operations themselves, like setting up dependencies between them.
///
/// APIOperation is implemented as a synchronous operation, intended to be run on a background 
/// thread (normally by NSOperationQueue. You can manually `start()` one if you wish, but because
/// Request completion handlers call back to the main thread, you cannot start an APIOperation on
/// the main thread (it will deadlock). They must be started in a background thread.

public class APIOperation: NSOperation {
    
    /// The Request instance that this operaton will run.
    
    let request: Request
    
    
    /// The completion handler for the request. (APIOperation will actually run the request using its own 
    /// handler, which will invoke completionHandler() before doing some additional housekeeping.)
    
    var completionHandler: ResponseHandler? = nil
    
    
    /// Private internal semaphore that lets us suspend this operation's subthread and wait for the signal that the completion handler has been executed (in a separate, arbitrary thread controlled by the OS).
    
    private let semaphore = dispatch_semaphore_create(0);

    
    /// Init with a Request instance and the completion handler that should be run by that request. (The completion handler will actually be wrapped in a separate handler that does a bit of additional housekeeping on behalf of the receiver).
    
    init(_ request: Request, completionHandler: ResponseHandler? = nil) {
        self.completionHandler = completionHandler
        self.request = request
        super.init()
        
        name = request.path
    }
    

    /// This is synchronous NSOperation subclass, so all work in done in this `main()` method:
    /// - check for cancelled status and abort if cancelled
    /// - run the request (which does networking in a separate, OS-controlled thread)
    /// - wait for the response to (or error result for) the request
    /// - finish

    override public func main() {
        
        guard !self.cancelled else {
            return
        }
        
        let originalHandler = completionHandler
        
        let extendedHandler: ResponseHandler = { (response) in
            
            if let originalHandler = originalHandler {
                originalHandler(response)
            }
            
            dispatch_semaphore_signal(self.semaphore);
        }
        
        request.run(extendedHandler)
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    
}
