
print("Hello, world!")

import SoracomSDKSwift


func loadCredentials()  {
    let client = SoracomSDKSwift.Client.sharedInstance
    
    let samCreds = client.credentialsForProductionSAMUser
    
    if samCreds.blank {
        print(samCreds)
        print("No credentials for production SAM user found. If you want to add them, enter '1':")
        if (readLine() == "1") {
            
            print("Enter authKeyId for a real SAM user:")
            guard let authKeyId = readLine() else {
                print("Canceled.")
                return
            } 
            
            print("Enter authKeySecret for a real SAM user:")
            guard let authKeySecret = readLine() else {
                print("Canceled.")
                return
            } 
            
            let productionCredentials = SoracomCredentials(type: .AuthKey, authKeyID: authKeyId, authKeySecret: authKeySecret)
            client.saveCredentials(productionCredentials, user: .ProductionSAMUser)
            print("Saved.")
        }
    }
}

Request.beforeRun { (request) in
    print(request)
}
Request.afterRun { (response) in
    print(response)
}

    
    
// client.doInitialHousekeeping()
// Mason 2017-07-15: lldb does not work on Linux[1], so the way we set credentials
// in the debugger on macOS/iOS does not work. That's why we do the below, for now.
// [1]: https://bugs.swift.org/browse/SR-3648

loadCredentials()

var creds = SoracomSDKSwift.SoracomCredentials.defaultSavedCredentials()

if creds.blank {

    print("No stored credentials found.")
    print("Creating initial credentials...")
    print("To start, you'll have to manually edit the credentials stored in:")
    print("    ~/.soracom-sdk-swift/")

    creds.type          = .RootAccount
    creds.authKeyID     = "REPLACE THIS TEXT WITH YOUR SAM USER AUTH KEY ID"
    creds.authKeySecret = "REPLACE THIS TEXT WITH YOUR SAM USER AUTH KEY SECRET"
    
    if creds.save() {
        print("Done.")
    } else {
        print("Uh-oh, saving credentials failed.")
    }
} else {
    print("Will use previously-stored credentials.")
}


let req = SoracomSDKSwift.Request.auth()
let res = req.wait()

print("Goodbye, world!")
