// DevelopmentEnvironmentTests.swift Created by mason on 2016-09-24.   Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation
import XCTest

/// This test case is usually a no-op and not that interesting. It is for testing this SDK
/// against local, under-development versions of the Soracom API. If you don't have a file
/// at ~/.soracom-sdk-swift/DevelopmentEnvironmentTests.json specifying an endpointHost and
/// login details for your local version of the API backend, this won't be useful (and won't
/// do anything).
///
/// SAMPLE FILE CONTENTS:
///
///    {
///        "endpointHost" : "api-sandbox.soracom.io",
///        "emailAddress" : "soracom+testbnkysuuuaw@soracom.jp@soracom.jp",
///        "password"     : "SoracomTest1001"
///    }

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
        
        let response = authRequest.wait()
        
        guard let authResponse = AuthResponse(response.payload) else {
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
    
    
    func test_newApiFutzing() {
        
        guard let endpointHost = endpointHost,
            let credentials  = apiKeyCredentials
            else {
                return
        }
        
        _ = endpointHost
        _ = credentials
        
        // BODY OF TEST HERE...
        
        let listReq = Request.listSubscribers()
        listReq.endpointHost = endpointHost;
        listReq.credentials = credentials;
        let listRes = listReq.wait()
        
        print(listRes)
        
        let req1 = Request.addCoverageType(.global, operatorId: "OP0026966374")
        
        req1.endpointHost = endpointHost
        req1.credentials = credentials
        
        let res1 = req1.wait()
        
        print(res1)
    }

    
}