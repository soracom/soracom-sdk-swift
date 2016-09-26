// DevelopmentEnvironmentTests.swift Created by mason on 2016-09-24.   Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation
import XCTest

/// This test case is usually a no-op and not that interesting. It is for testing this SDK
/// against local, under-development versions of the Soracom API. If you don't have a file
/// at ~/.soracom-sdk-swift/DevelopmentEnvironmentTests.json specifying an endpointHost and
/// login details for your local version of the API backend, this won't be useful (and won't
/// do anything.

class DevelopmentEnvironmentTests: XCTestCase {

    var testValues: [String:String]? {
        
        var result: [String:String]? = nil
        
        let path = NSString(string: "~/.soracom-sdk-swift/DevelopmentEnvironmentTests.json").expandingTildeInPath
        let url  = URL(fileURLWithPath:path)
        
        if let data = try? Data(contentsOf: url),
           let obj  = try? JSONSerialization.jsonObject(with: data ),
           let dict = obj as? [String:String]
        {
            result = dict
        }
        return result
    }
    
    var endpointHost: String? {
        return testValues?["endpointHost"]
    }
    
    var emailAddress: String? {
        return testValues?["emailAddress"]
    }
    
    var password: String? {
        return testValues?["password"]
    }
    
    var rootCredentials: SoracomCredentials? {
        
        guard let emailAddress = emailAddress,
              let password     = password
        else {
            return nil
        }
        
        return SoracomCredentials(type: .RootAccount, emailAddress: emailAddress, operatorID: "", username: "", password: password, authKeyID: "", authKeySecret: "", apiKey: "", token: "")
    }
    
    var apiKeyCredentials: SoracomCredentials? {
        
        guard let endpointHost = endpointHost,
              let credentials  = rootCredentials
        else {
            return nil
        }
        
        let authRequest = Request.auth(credentials)
        authRequest.endpointHost = endpointHost
        
        guard let authResponse = AuthResponse(authRequest.wait().payload) else {
            XCTFail("Hmm. Test precondition failed: unable to authenticate to get API key")
            return nil
        }
        
        let apiKeyCredentials = SoracomCredentials(apiKey: authResponse.apiKey!, token: authResponse.token!);
        return apiKeyCredentials
    }
    
    
    func test_flipImeiLock() {
        
        guard let endpointHost = endpointHost,
              let credentials  = apiKeyCredentials
        else {
            return
        }
        
        _ = endpointHost
        _ = credentials
        
        // BODY OF TEST HERE...
    }

    
}
