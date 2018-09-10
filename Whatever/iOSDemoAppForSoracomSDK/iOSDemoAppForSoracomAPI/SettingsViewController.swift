    // SettingsViewController.swift Created by mason on 2016-05-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import UIKit
    
class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let credentials = Client.sharedInstance.credentialsForProductionSAMUser
        
        authKeyIDField.text     = credentials.authKeyID
        authKeySecretField.text = credentials.authKeySecret
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("\(self): prepareForSegue: \(segue)")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("\(self): viewWillDisappear: \(animated)")
        saveSAMUserCredentials()
    }
    
    
    func saveSAMUserCredentials() {
        
        
        let authKeyID      = authKeyIDField.text ?? ""
        let authKeySecret  = authKeySecretField.text ?? ""
        let newCredentials = SoracomCredentials(type: .AuthKey,  authKeyID: authKeyID, authKeySecret: authKeySecret)
        
        let oldCredentials = Client.sharedInstance.credentialsForUser(.ProductionSAMUser)
        if (oldCredentials != newCredentials) {
            Client.sharedInstance.saveCredentials(SoracomCredentials(), user: .APISandboxUser) // nuke old ones
            Client.sharedInstance.saveCredentials(newCredentials, user: .ProductionSAMUser)
            Client.sharedInstance.createSandboxUser()
        }
        
        Client.sharedInstance.authenticateAsSandboxUser(false)
    }
    
    
    @IBOutlet weak var authKeyIDField:     UITextField!
    @IBOutlet weak var authKeySecretField: UITextField!
    
}
