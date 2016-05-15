    // SettingsViewController.swift Created by mason on 2016-05-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import UIKit

class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let credentials = Credentials.credentialsForProductionSAMUser
        
        authKeyIDField.text     = credentials.authKeyID
        authKeySecretField.text = credentials.authKeySecret
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("\(self): prepareForSegue: \(segue)")
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        print("\(self): viewWillDisappear: \(animated)")
        saveSAMUserCredentials()
    }
    
    
    func saveSAMUserCredentials() {
        
        // let oldCredentials = Credentials.credentialsForProductionSAMUser()
        let authKeyID      = authKeyIDField.text ?? ""
        let authKeySecret  = authKeySecretField.text ?? ""
        let newCredentials = SoracomCredentials(type: .AuthKey,  authKeyID: authKeyID, authKeySecret: authKeySecret)
        
        newCredentials.writeToSecurePersistentStorage()
        
        // FIXME: maybe don't crete new sandbox user unless ______?
        
        Credentials.authenticateAsSandboxUser(recreateOnFailure: true)
    }
    
    
    @IBOutlet weak var authKeyIDField:     UITextField!
    @IBOutlet weak var authKeySecretField: UITextField!
}
