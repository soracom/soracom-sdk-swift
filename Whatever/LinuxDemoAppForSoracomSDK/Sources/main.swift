
print("Hello, world!")

import SoracomSDKSwift

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

Request.beforeRun { (request) in
    print(request)
}

let req = SoracomSDKSwift.Request.auth()
let res = req.wait()
print(res)

print("Goodbye, world!")
