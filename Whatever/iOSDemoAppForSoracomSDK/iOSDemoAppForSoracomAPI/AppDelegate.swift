// AppDelegate.swift Created by mason on 2016-05-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import UIKit

import SoracomAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("🤖 Welcome to the iOS Demo App for the Soracom Swift SDK.")
        
        BaseRequest.credentialsFinder = { (req) in
            
            // For almost everything it does, this app will use the credentials for the API Sandbox user.
            // The only exception is the real SAM user credentials it needs to create the sandbox user.
            
            return Client.sharedInstance.credentialsForSandboxUser
        }

        Client.sharedInstance.doInitialHousekeeping()
          // This will allow us to use Xcode to securely input credentials that can be used by the tests.
          // You can set a breakpoint in that method (see its comments) and then enter your credentials
          // in the lldb debugger console inside Xcode (which may be easier than trying to enter the long
          // AuthKey ID and secret in the iOS app itself).

        return true
    }
    
    
}

