// This playground lets you mess around with the SoracomAPI.
//
// Sometimes this might be the most convenient way to try things out.

import Cocoa
import SoracomAPI

func authenticate() {
    
    // AUTHENTICATION
    // Before we can do much, we will need to authenticate. Replace the
    // values below with your test credentials:
    
    var creds = SoracomCredentials(
        emailAddress: "C52A1E26-FE98-4C76-B59E-FB8F35222B49@example.com",
        password:     "C52A1E26-FE98-4C76-B59E-FB8F35222B49aBc0157$"
    )
    
    let authResponse = Request.auth(creds).wait()
    print(authResponse)
    
    guard
        let authResult = authResponse.parse(),
        let apiKey     = authResult.apiKey,
        let token      = authResult.token
        else {
            fatalError("Whoops! 😅 Maybe check that email address & password?")
    }
    print(authResult)
    
    creds.apiKey = apiKey
    creds.token  = token
    
    BaseRequest.credentialsFinder = { (BaseRequest) in
        print("credentials finder is returning our credentials 👍")
        return creds
    }
    
    print("Updated the credentials that will be used from here on.")
}

authenticate()

// 🚀 LET'S GO!
// Now we've authenticated; if that succeeded, then we should be able
// to try whatever API calls we want.


let req    = Request.listSubscribers()
let res    = req.wait()
let status = res.statusCode
let result = res.parse()

let subscriberCount = result!.count

print("🍒 I found \(subscriberCount) subscribers.")
// print(res)



