// MainViewController.swift Created by mason on 2016-05-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import UIKit

class MainViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SORACOM SDK Demo"
        
        let nc = NSNotificationCenter.defaultCenter()
        
        nc.addObserverForName(Notifications.SandboxUserAuthenticationDidUpdate, object: nil, queue: nil) { (notif) in
            
            self.authStatusField.text  = Client.sharedInstance.sandboxUserAuthenticationStatus
            self.helpMessageField.text = Client.sharedInstance.helpMessage
        }
        
        authStatusField.text = Client.sharedInstance.sandboxUserAuthenticationStatus
        helpMessageField.text = Client.sharedInstance.helpMessage

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("\(self): prepareForSegue: \(segue)")
    }

    
    override func viewWillDisappear(animated: Bool) {
        print("\(self): viewWillDisappear: \(animated)")
    }
 
    
    @IBOutlet weak var authStatusField:  UILabel!
    @IBOutlet weak var helpMessageField: UILabel!

    
    @IBAction func startButtonPressed(sender: AnyObject) {
        
        Client.sharedInstance.authenticateAsSandboxUser(true)
        // trigger auth and update the status display
        
    }

}
