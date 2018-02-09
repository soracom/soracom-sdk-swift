
print("Hello, world!")

import SoracomAPI

let client = SoracomAPI.Client.sharedInstance

func loadCredentials()  {
    
    let samCreds = client.credentialsForProductionSAMUser
    
    if samCreds.blank {
        // print(samCreds)
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

var creds = client.credentialsForUser(.ProductionSAMUser)

if creds.blank {

    print("No stored credentials found.")
    print("Creating initial credentials...")
    print("To start, you'll have to manually edit the credentials stored in:")
    print("    ~/.soracom-sdk-swift/")

    creds.type          = .AuthKey
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

let message = """

FIXME: This program cannot actually log into the API Sandbox yet. All it
can do is attempt to authenticate, and get rejected. A few more steps need
to be implemented (namely, creating a user in the API Sandbox, and using
that user's credentials to authenticate).

Will now attempt to log in, and fail:

"""

print(message)

let req = SoracomAPI.Request.auth(creds);

let res = req.wait()

print("Goodbye, world!")
