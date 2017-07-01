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
    
    let kFontSizeKey      = "font-size-for-transcript"
    var fontSize: CGFloat = 10.0
    
    /// A reference to the singleton Client instance, which implements most of the API-related behavior of this demo app.
    
    let apiClient = Client()
    
    
    /// Initial housekeeping
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        apiClient.logger = { (str: String, attrs: TextStyle) in
            self.log(str, attrs: attrs)
        }
        
        // This app can't really do anything without some credentials that allow
        // it to use the API Sandbox. So we try to load them on launch:
        
        loadCredentials()
        
        // In this app, since it is an experimental/exploratory tool, we want to log every
        // request and response made. This is easy to do using beforeRun() and afterRun():
        
        Request.beforeRun { (request) in
            DispatchQueue.main.async {
                self.log("\(request)", attrs: .blue)
            }
        }
        
        Request.afterRun { (response) in
            DispatchQueue.main.async {
                let attrs: TextStyle = response.error != nil ? .red : .green
                self.log("\(response)", attrs: attrs)
            }
        }
        
        redactSwitch.state = RequestResponseFormatter.shouldRedact ? NSOnState : NSOffState
        
        Request.credentialsFinder = { (request) in
            // This app is unusual since it does most things as a user in the API Sandbox, but sometimes
            // needs production credentials too. Here we set the default credentials to the ones we store
            // for the sandbox user. This makes these the default credentials used by all requests, unless
            // otherwise specified.
            
            return Client.sharedInstance.credentialsForSandboxUser
        }
        
        Client.sharedInstance.doInitialHousekeeping()
          // This will allow us to use Xcode to securely input credentials that can be used by the tests.
        
        let preferredFontSize = UserDefaults.standard.float(forKey: kFontSizeKey);
        if (preferredFontSize > 1.0) {
            fontSize = CGFloat(preferredFontSize)
        }
        
        log("🤘 SORACOM API Swift SDK demo app is ready.")
    }
    
    
    /// NSControl delegate — used to notice when the user edits credentials, and save them.
    
    override func controlTextDidChange(_ obj: Notification) {
        
        if let control = obj.object as? NSTextField {
            
            if control == authKeyIDField || control == authKeySecretField  {
            
                let sel = #selector(AppDelegate.saveCredentials)
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: sel, object: nil)
                self.perform(sel, with: nil, afterDelay: 0.3, inModes: [RunLoopMode.commonModes])
            }
        }
    }
    
    
    /// Loads credentials and updates GUI. Informs user if no credentials exist.
    
    func loadCredentials() {
        let productionCredentials      = Client.sharedInstance.credentialsForProductionSAMUser
        authKeyIDField.stringValue     = productionCredentials.authKeyID
        authKeySecretField.stringValue = productionCredentials.authKeySecret
        
        if productionCredentials.blank {
            log("There are no stored production SAM user credentials, so this may not be useful.")
            log("Enter the AuthKey ID and AuthKey secret for a SAM user in the boxes above.")
        }
        
        let sbc = Client.sharedInstance.credentialsForSandboxUser
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
        
        Client.sharedInstance.saveCredentials(credentials, user: .ProductionSAMUser)
    }
    
    
    /// Utility func.
    
    func copyStringToPasteboard(_ str: String) {
        let pasteBoard = NSPasteboard.general()
        pasteBoard.clearContents()
        pasteBoard.writeObjects([str as NSPasteboardWriting])
    }
    
    
    /// Log the text in the main window, color-coded for clarity.
    
    func log(_ str: String, attrs: TextStyle = .normal) {
        
        func appendOutput(_ text: String, attrs: [String:AnyObject]) {
            // We should at some point move this to extension of NSTextView
            let attrStr = NSAttributedString(string: text, attributes: attrs)
            outputTextView.textStorage!.append(attrStr)
            outputTextView.scrollRangeToVisible(NSRange(location: outputTextView.textStorage!.length, length: 0))
        }
        var padded = str
        if str.characters.first != "\n" {
            padded = "\n" + padded
        }
        if str.characters.last != "\n" {
            padded = padded + "\n"
        }
        var updatedAttrs = attrs.attributes
        updatedAttrs[NSFontAttributeName] = defaultFont(size: fontSize);
        appendOutput(padded, attrs: updatedAttrs)
        
        print(str)  // pad it in the app output only
    }
    
    
    // MARK: - UI actions
    
    @IBAction func clearLog(_ sender: AnyObject) {
        let cleared = NSAttributedString(string: "", attributes: [NSFontAttributeName: NSFont.userFixedPitchFont(ofSize: fontSize)!])
        outputTextView.textStorage?.setAttributedString(cleared)
    }
    
    @IBAction func copyAuthKeyID(_ sender: AnyObject) {
        copyStringToPasteboard(Client.sharedInstance.credentialsForProductionSAMUser.authKeyID)
    }
    
    
    @IBAction func copyAuthKeySecret(_ sender: AnyObject) {
        copyStringToPasteboard(Client.sharedInstance.credentialsForProductionSAMUser.authKeySecret)
    }
    
    
    @IBAction func createSandboxUser(_ sender: AnyObject) {
        
        let emailAddress = sandboxUserEmailField.stringValue
        let password     = sandboxUserPasswordField.stringValue

        apiClient.createSandboxUser(email: emailAddress, password:password)
    }
    

    @IBAction func authWithSandboxUserCredentials(_ sender: AnyObject) {
        apiClient.authenticateSandboxUserAndUpdateStoredCredentials()
    }
    
    
    @IBAction func deleteSandboxUserCredentials(_ sender: AnyObject) {
        
        log("🚀 Will try to delete the stored credentials for the API Sandbox user...")
        
        let credentials = Client.sharedInstance.credentialsForSandboxUser
        
        guard !credentials.blank else {
            log("No credentials were found, so nothing was deleted.")
            return
        }
        
        // FIXME: make this work: Client.sharedInstance.deleteCredentialsForUser(.APISandboxUser)
        
        Client.sharedInstance.saveCredentials(SoracomCredentials(), user: .APISandboxUser)
        
        // SoracomCredentials.sandboxCredentials = SoracomCredentials()
        // Mason 2016-04-23: that's a fairly hackneyed method of deletion, bro...
        
        self.log("Stored credentials deleted successfully. 😁")
        loadCredentials()
    }
    
    
    @IBAction func createSandboxSIMs(_ sender: AnyObject) {
        apiClient.createSandboxSIM()
    }
    
    
    @IBAction func listSandboxSIMs(_ sender: AnyObject) {
        apiClient.listSandboxSIMs()
    }
    
    
    @IBAction func updateRedactionOption(_ sender: NSButton) {
        let newValue = sender.state == NSOnState
        RequestResponseFormatter.shouldRedact = newValue
        log("Redaction set to \(newValue ? "ON" : "OFF").")
    }
    
    
    @IBAction func increaseFontSize(_ sender: AnyObject) {
        adjustFontSizeBy(1.0)
    }
    
    
    @IBAction func decreaseFontSize(_ sender: AnyObject) {
        adjustFontSizeBy(-1.0)
    }
    
    
    func adjustFontSizeBy(_ adjustment: CGFloat) {
        
        let newFontSize = fontSize + adjustment
        
        guard (newFontSize > 4.0 && newFontSize < 145.0) else {
            // a real app would properly validate/disable the menu items, but...
            NSBeep();
            return;
        }
        fontSize = newFontSize
        UserDefaults.standard.set(Float(fontSize), forKey: kFontSizeKey)
        
        let newFont = defaultFont(size: fontSize);
        let length  = outputTextView.attributedString().length
        let range   = NSMakeRange(0, length);
        
        outputTextView.setFont(newFont, range: range);
    }
    
    
    func defaultFont(size: CGFloat) -> NSFont {
        
        guard let result = NSFont.userFixedPitchFont(ofSize: fontSize) else {
            return NSFont.systemFont(ofSize: fontSize)
        }
        return result;
    }
    
}
