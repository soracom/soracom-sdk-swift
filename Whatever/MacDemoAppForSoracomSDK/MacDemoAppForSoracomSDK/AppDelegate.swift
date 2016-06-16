// AppDelegate.swift Created by mason on 2016-03-10. Copyright © 2016 Soracom, Inc. All rights reserved.


import Cocoa

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var sandboxUserEmailField: NSTextField!
    @IBOutlet weak var sandboxUserPasswordField: NSTextField!
    @IBOutlet weak var authKeyIDField: NSTextField!
    @IBOutlet weak var authKeySecretField: NSTextField!
    @IBOutlet weak var redactSwitch: NSButton!
    @IBOutlet var outputTextView: NSTextView!
      // Mason 2016-03-13: NOTE: For historical reasons, NSTextView is marked as NS_AUTOMATED_REFCOUNT_WEAK_UNAVAILABLE, so weak ref will cause crash. (In this app, we don't really care, though.)
    
    
    /// A reference to the singlton Client instance, which implements most of the API-related behavior of this demo app.
    
    let apiClient = Client()
    
    
    /// Initial housekeeping
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        apiClient.logger = { (str: String, attrs: TextStyle) in
            self.log(str, attrs: attrs)
        }
        
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
        
        Request.credentialsFinder = { (request) in
            // This app is unusual since it does most things as a user in the API Sandbox, but sometimes
            // needs production credentials too. Here we set the default credentials to the ones we store
            // for the sandbox user. This makes these the default credentials used by all requests, unless
            // otherwise specified.
            
            return SoracomCredentials.sandboxCredentials
        }
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
        let productionCredentials = SoracomCredentials.productionCredentials
        authKeyIDField.stringValue = productionCredentials.authKeyID
        authKeySecretField.stringValue = productionCredentials.authKeySecret
        
        if productionCredentials.blank {
            log("There are no stored production SAM user credentials, so this may not be useful.")
            log("Enter the AuthKey ID and AuthKey secret for a SAM user in the boxes above.")
        }
        
        let sbc = SoracomCredentials.sandboxCredentials
        sandboxUserEmailField.stringValue = sbc.emailAddress
        if sbc.blank {
            log("There are no stored sandbox user credentials.")
        }
    }
    
    
    func saveCredentials() {
        
        var credentials           = SoracomCredentials()
        credentials.type          = .AuthKey
        credentials.authKeyID     = authKeyIDField.stringValue
        credentials.authKeySecret = authKeySecretField.stringValue
        
        SoracomCredentials.productionCredentials = credentials        
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
    
    @IBAction func clearLog(sender: AnyObject) {
        let cleared = NSAttributedString(string: "", attributes: [NSFontAttributeName: NSFont.userFixedPitchFontOfSize(10.0)!])
        outputTextView.textStorage?.setAttributedString(cleared)
    }
    
    @IBAction func copyAuthKeyID(sender: AnyObject) {
        copyStringToPasteboard(SoracomCredentials.productionCredentials.authKeyID)
    }
    
    
    @IBAction func copyAuthKeySecret(sender: AnyObject) {
        copyStringToPasteboard(SoracomCredentials.productionCredentials.authKeySecret)
    }
    
    
    @IBAction func createSandboxUser(sender: AnyObject) {
        
        let emailAddress = sandboxUserEmailField.stringValue
        let password     = sandboxUserPasswordField.stringValue

        apiClient.createSandboxUser(email: emailAddress, password:password)
    }
    

    @IBAction func authWithSandboxUserCredentials(sender: AnyObject) {
        apiClient.authenticateSandboxUserAndUpdateStoredCredentials()
    }
    
    
    @IBAction func deleteSandboxUserCredentials(sender: AnyObject) {
        
        log("🚀 Will try to delete the stored credentials for the API Sandbox user...")
        
        let credentials = SoracomCredentials.sandboxCredentials
        
        guard !credentials.blank else {
            log("No credentials were found, so nothing was deleted.")
            return
        }
        
        SoracomCredentials.sandboxCredentials = SoracomCredentials()
        // Mason 2016-04-23: that's a fairly hackneyed method of deletion, bro...
        
        self.log("Stored credentials deleted successfully. 😁")
        loadCredentials()
    }
    
    
    @IBAction func createSandboxSIMs(sender: AnyObject) {
        apiClient.createSandboxSIM()
    }
    
    
    @IBAction func listSandboxSIMs(sender: AnyObject) {
        apiClient.listSandboxSIMs()
    }
    
    
    @IBAction func updateRedactionOption(sender: NSButton) {
        let newValue = sender.state == NSOnState
        RequestResponseFormatter.shouldRedact = newValue
        log("Redaction set to \(newValue ? "ON" : "OFF").")
    }
    
}
