// AppDelegate.swift Created by mason on 2016-03-10. Copyright © 2016 Soracom, Inc. All rights reserved.


import Cocoa

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var dummyEmailField: NSTextField!
    @IBOutlet weak var authKeyIDField: NSTextField!
    @IBOutlet weak var authKeySecretField: NSTextField!
    @IBOutlet weak var redactSwitch: NSButton!
    @IBOutlet var outputTextView: NSTextView!
      // Mason 2016-03-13: NOTE: For historical reasons, NSTextView is marked as NS_AUTOMATED_REFCOUNT_WEAK_UNAVAILABLE, so weak ref will cause crash. (In this app, we don't really care, though.)
    
    
    /// The single operation used to schedule operations
    
    let queue = NSOperationQueue()
    
    
    /// Returns the **production** credentials from the production Soracom environment, which (for the purposes of this demo app) should be the AuthKey ID and AuthKey Secret of a SAM user. (You can use the real Soracom web console to create a SAM user for testing.) These credentials are needed to create a dummy user in the API Sandbox, and can be entered in the main window.
    
    var productionCredentials: SoracomCredentials {
        return SoracomCredentials(withStoredType: .AuthKey)
    }
    
    
    /// Returns the credentials of the API Sandbox user. This demo app saves credentials for only one sandbox user at a time (which can be recreated whenever needed from the main window). Since this app also has to store a set of real-world credentials for a SAM user, it uses a different storage namespace for the sandbox user's credentials.
    
    var sandboxUserCredentials: SoracomCredentials {
        return SoracomCredentials(withStorageIdentifier: nil, namespace: dummyUserStorageNamespace)
    }

    /// A separate namespace in which credentials for dummy users (API Sandbox users) are stored
    
    let dummyUserStorageNamespace = NSUUID(UUIDString: "DEAE490F-0A00-49CD-B2AF-401215E15122")!

    
    /// Initial housekeeping
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        queue.maxConcurrentOperationCount = 1 // keep it simple and easy to follow
        
        // This app can't really do anything without some credentials that allow
        // it to use the API Sandbox. So we try to load them on launch:
        
        loadCredentials()
        
        // In this app, since it is an experimental/exploratory tool, we want to log every
        // request and response made. This is easy to do using beforeRun() and afterRun():
        
        Request.beforeRun { (request) in
            dispatch_async(dispatch_get_main_queue()) {
                self.log("\(request)", attrs: .Blue)
            }
        }
        
        Request.afterRun { (response) in
            dispatch_async(dispatch_get_main_queue()) {
                let attrs: TextStyle = response.error != nil ? .Red : .Green
                self.log("\(response)", attrs: attrs)
            }
        }
        
        redactSwitch.state = RequestResponseFormatter.shouldRedact ? NSOnState : NSOffState
    }
    
    
    /// NSControl delegate — used to notice when the user edits credentials, and save them.
    
    override func controlTextDidChange(obj: NSNotification) {
        
        if let control = obj.object as? NSTextField {
            
            if control == authKeyIDField || control == authKeySecretField  {
            
                let sel = #selector(AppDelegate.saveCredentials)
                NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: sel, object: nil)
                self.performSelector(sel, withObject: nil, afterDelay: 0.3, inModes: [NSRunLoopCommonModes])
            }
        }
    }
    
    
    /// Loads credentials and updates GUI. Informs user if no credentials exist.
    
    func loadCredentials() {
        
        authKeyIDField.stringValue = productionCredentials.authKeyID
        authKeySecretField.stringValue = productionCredentials.authKeySecret
        
        if productionCredentials.blank {
            log("There are no stored production SAM user credentials, so this may not be useful.")
            log("Enter the AuthKey ID and AuthKey secret for a SAM user in the boxes above.")
        }
        
        let sbc = sandboxUserCredentials
        dummyEmailField.stringValue = sbc.emailAddress
        if sbc.blank {
            log("There are no stored sandbox user credentials.")
        }
    }
    
    
    func saveCredentials() {
        
        var credentials           = SoracomCredentials()
        credentials.type          = .AuthKey
        credentials.authKeyID     = authKeyIDField.stringValue
        credentials.authKeySecret = authKeySecretField.stringValue
        
        if !credentials.writeToSecurePersistentStorage() {
            fatalError("can't save credentials")
        } else {
            log("Saved production SAM user credentials.")
        }
        
    }
    
    
    /// Utility func.
    
    func copyStringToPasteboard(str: String) {
        let pasteBoard = NSPasteboard.generalPasteboard()
        pasteBoard.clearContents()
        pasteBoard.writeObjects([str])
    }
    
    
    /// Log the text in the main window, color-coded for clarity.
    
    func log(str: String, attrs: TextStyle = .Normal) {
        
        func appendOutput(text: String, attrs: [String:AnyObject]) {
            // We should at some point move this to extension of NSTextView
            let attrStr = NSAttributedString(string: text, attributes: attrs)
            outputTextView.textStorage!.appendAttributedString(attrStr)
            outputTextView.scrollRangeToVisible(NSRange(location: outputTextView.textStorage!.length, length: 0))
        }
        var padded = str
        if str.characters.first != "\n" {
            padded = "\n" + padded
        }
        if str.characters.last != "\n" {
            padded = padded + "\n"
        }
        
        appendOutput(padded, attrs: attrs.attributes) // pad it in the app output
        print(str)
    }
    
    
    // MARK: - UI actions
    
    @IBAction func copyAuthKeyID(sender: AnyObject) {
        copyStringToPasteboard(productionCredentials.authKeyID)
    }
    
    
    @IBAction func copyAuthKeySecret(sender: AnyObject) {
        copyStringToPasteboard(productionCredentials.authKeySecret)
    }
    
    
    @IBAction func createDummyUser(sender: AnyObject) {
        createSandboxUser()
    }
    

    @IBAction func authWithDummyUserCredentials(sender: AnyObject) {
        self.authWithCredentials(sandboxUserCredentials, userType: .Sandbox)
    }
    
    
    @IBAction func deleteSandboxUserCredentials(sender: AnyObject) {
        
        log("🚀 Will try to delete the stored credentials for the API Sandbox user...")
        
        let credentials = sandboxUserCredentials
        
        guard !credentials.blank else {
            log("No credentials were found, so nothing was deleted.")
            return
        }
        
        SoracomCredentials().writeToSecurePersistentStorage(namespace: self.dummyUserStorageNamespace)
        // Mason 2016-04-23: that's a fairly hackneyed method of deletion, bro...
        
        self.log("Stored credentials deleted successfully. 😁")
        loadCredentials()
    }
    
    
    @IBAction func createDummySIMs(sender: AnyObject) {
        createSandboxSIM()
    }
    
    @IBAction func updateRedactionOption(sender: NSButton) {
        let newValue = sender.state == NSOnState
        RequestResponseFormatter.shouldRedact = newValue
        log("Redaction set to \(newValue ? "ON" : "OFF").")
    }
    
    
    @IBAction func debug1(sender: AnyObject) {
        log("🐞 DEBUG 1: This will print the operation queue. Edit debug1() in AppDelegate.swift to change what this does.")
        log("\(queue.operations)")
    }
    
    
    @IBAction func debug2(sender: AnyObject) {
        log("🐜 DEBUG 2: This doesn't do anything except log this message. Edit debug2() in AppDelegate.swift to change what this does.")
    }
    
    
    @IBAction func debug3(sender: AnyObject) {
        
        log("🐛 DEBUG 3: This doesn't do anything except log this message. Edit debug3() in AppDelegate.swift to change what this does.")
    }
    
}


/// The two types of user this demo app knows about.

enum UserType {
    
    /// The actual production SAM user (in this demo app, used only for creating a dummy user in the API Sandbox)
    case Production
    
    /// The dummy sandbox user, used to play with the API
    case Sandbox
}
