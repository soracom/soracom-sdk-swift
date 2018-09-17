// MainViewController.swift Created by mason on 2016-05-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import UIKit

class MainViewController: UIViewController {
    
    private var sandboxMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cleans any perhaps expired tokens and removes sandbox user
        self.cleanStart()
        
        self.title = "SORACOM SDK Demo"
        
        let nc = NotificationCenter.default
        
        nc.addObserver(forName: Notifications.SandboxUserAuthenticationDidUpdate, object: nil, queue: nil) { (notif) in
            self.updateDisplay()
        }
        
        self.updateDisplay()

    }
    
    func updateDisplay(){
        self.authStatusField.text  = Client.sharedInstance.sandboxUserAuthenticationStatus
        self.helpMessageField.text = Client.sharedInstance.helpMessage
        
        if (self.sandboxMode){
            let cred = Client.sharedInstance.credentialsForSandboxUser
            self.viewSubscribersButton.isHidden = (cred.token == "")
            self.authButton.isHidden = (cred.token != "")
        } else {
            let cred = Client.sharedInstance.credentialsForProductionSAMUser
            self.viewSubscribersButton.isHidden = (cred.token == "")
            self.authButton.isHidden = (cred.token != "")
        }
        self.sandboxSwitch.isOn = self.sandboxMode
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("\(self): prepareForSegue: \(segue)")
        if (segue.identifier == "ShowSubscribers"){
            guard let dest = segue.destination as? SubscribersTableViewController else {
                return
            }
            dest.sandboxMode = self.sandboxMode
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        print("\(self): viewWillDisappear: \(animated)")
    }
 
    
    @IBOutlet weak var sandboxSwitch: UISwitch!
    @IBOutlet weak var authStatusField:  UILabel!
    @IBOutlet weak var helpMessageField: UILabel!
    @IBOutlet weak var viewSubscribersButton: UIButton!
    @IBOutlet weak var authButton: UIButton!
    
    @IBAction func sandboxModeChanged(_ sender: UISwitch) {
        if (sender.isOn){
            BaseRequest.endpointHost = BaseRequest.sandboxEndpointHost
            BaseRequest.credentialsFinder = { (req) in
                return Client.sharedInstance.credentialsForSandboxUser
            }
        } else {
            BaseRequest.endpointHost = BaseRequest.productionEndpointHost
            BaseRequest.credentialsFinder = { (req) in
                return Client.sharedInstance.credentialsForProductionSAMUser
            }
        }
        self.sandboxMode = sender.isOn
        self.updateDisplay()
    }
    
    @IBAction func startButtonPressed(sender: AnyObject) {
        
        if (self.sandboxMode){
            Client.sharedInstance.authenticateAsSandboxUser(true)
        } else {
            self.performProductionAuth()
        }
        // trigger auth and update the status display
    }
    
    func performProductionAuth(){
        
        var credentials = Client.sharedInstance.credentialsForProductionSAMUser
        let authReq = Request.auth(credentials) { (response) in
            print("Auth: \(response)")
            if let authResponse = response.parse(),
                let apiKey = authResponse.apiKey,
                let token  = authResponse.token
            {
                credentials.apiKey = apiKey
                credentials.token  = token
                _ = credentials.save()
                Client.sharedInstance.saveCredentials(credentials, user: .ProductionSAMUser)
                
                self.authStatusField.text = "🆗 Authenticated as: \(credentials.apiKey)"
                self.helpMessageField.text = ""
                self.updateDisplay()
                
            } else {
                
                let message = response.error?.message ?? "generic error"
                self.authStatusField.text = "⚠️ Failed: \(message)"
                self.helpMessageField.text = "(Valid SAM user credentials from the production environment are required.)"
                self.updateDisplay()

            }
            
        }
        authReq.run()
    }
    
    func cleanStart(){
        var credentials = Client.sharedInstance.credentialsForProductionSAMUser
        credentials.token  = ""
        _ = credentials.save()
        Client.sharedInstance.saveCredentials(credentials, user: .ProductionSAMUser)
        
        // Completely nuke sandbox user
        Client.sharedInstance.saveCredentials(SoracomCredentials(), user: .APISandboxUser)
    }

}
