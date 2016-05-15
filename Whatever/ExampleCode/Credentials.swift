// Credentials.swift Created by mason on 2016-05-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

public class Credentials {
    
    
    /// Returns the credentials for the API Sandbox user. (May be blank.)
    
    public static var credentialsForSandboxUser: SoracomCredentials {
        return SoracomCredentials(withStorageIdentifier: nil)
    }
    
    
    /// Persist the credentials for the API Sandbox user to secure storage.
    
    public static func saveCredentialsForSandboxUser(credentials: SoracomCredentials) -> Bool {

        guard credentials.type == .RootAccount else {
            print("WARNING: this app is calling saveCredentialsForSandboxUser() with the wrong credential type. Nothing will be saved.")
            print(credentials)
            return false
        }
        
        return credentials.writeToSecurePersistentStorage(replaceDefault: true)
    }
    
    
    /// Returns the credentials for the production SAM user. (May be blank.)
    
    public static var credentialsForProductionSAMUser: SoracomCredentials {
        return SoracomCredentials(withStoredType: .AuthKey)
    }
    
    
    /// Persist the credentials for the production SAM user to secure storage.
    
    public static func saveCredentialsForProductionSAMUser(credentials: SoracomCredentials) -> Bool {
        
        guard credentials.type == .AuthKey else {
            print("WARNING: this app is calling saveCredentialsForProductionSAMUser() with the wrong credential type. Nothing will be saved.")
            print(credentials)
            return false
        }
        return credentials.writeToSecurePersistentStorage()
    }
    
    
    /// Try to authenticate as sandbox user, and post notification with the result.
    
    public static func authenticateAsSandboxUser(recreateOnFailure recreateOnFailure: Bool = false) {
        
        var credentials = credentialsForSandboxUser
        let nc = NSNotificationCenter.defaultCenter()

        guard !credentials.blank else {
            sandboxUserAuthenticationStatus = "⚠️ There is no API Sandbox user. To create one, enter your credentials in Settings."
            nc.postNotificationName(Notifications.SandboxUserAuthenticationDidUpdate, object: nil)
            
            if recreateOnFailure {
                self.createSandboxUser()
            }

            return
        }
        
        let authReq     = Request.auth(credentials)
        
        authReq.run { (response) in
            
            
            if let payload = response.payload,
                apiKey  = payload[.apiKey] as? String,
                token   = payload[.token] as? String
            {
                credentials.apiKey   = apiKey
                credentials.apiToken = token
                credentials.writeToSecurePersistentStorage()
                
                sandboxUserAuthenticationStatus = "🆗 Authenticated as: \(credentials.emailAddress)"
                
            } else {
                
                sandboxUserAuthenticationStatus = "⚠️ Failed: \(response.error?.message)"
                
                if recreateOnFailure {
                    self.createSandboxUser()
                }
            }
            
            nc.postNotificationName(Notifications.SandboxUserAuthenticationDidUpdate, object: nil)
        }
    }
    
    
    public static func createSandboxUser() {
    
        let unique   = NSUUID().UUIDString.componentsSeparatedByString("-")[0]
        let email    = "sandbox-\(unique)@example.com"
        let password = "p4$$w0Rd-\(unique)"

        let finalOperation = NSBlockOperation { 
            self.authenticateAsSandboxUser()
        }
        
        ExampleCode.sharedInstance.createSandboxUser(email, password: password, finalOperation:finalOperation)
    }
    
    
    public static var sandboxUserAuthenticationStatus = "Checking..."


}