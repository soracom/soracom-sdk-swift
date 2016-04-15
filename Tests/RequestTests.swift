// RequestTests.swift Created by mason on 2016-03-20. Copyright © 2016 Soracom, Inc. All rights reserved.


import XCTest

class RequestTests: BaseTestCase {
    
    func test_lookup_credentials_for_HTTP_headers() {
        // By default, Request will look up the "default" stored credentials of type SoracomCredentialType.KeyAndToken. However, the client
        // code may override that behavior by passing a function/closure to do the lookup. This can be done on a global or per-instance basis.
        
        let defaultCredentials  = SoracomCredentials(type: .KeyAndToken, emailAddress: "default@foo.bar", apiKey: "default", apiToken: "default")
        let instanceCredentials = SoracomCredentials(type: .KeyAndToken, emailAddress: "instance@foo.bar", apiKey: "instance", apiToken: "instance")
        let globalCredentials   = SoracomCredentials(type: .KeyAndToken, emailAddress: "global@foo.bar", apiKey: "global", apiToken: "global")
        
        defaultCredentials.writeToSecurePersistentStorage()
        
        // An instance-level override should override how credentials are looked up for that instance only...
        let instanceRequest     = Request("/foo")
        instanceRequest.credentialsFinder = { (req) in
            return instanceCredentials
        }
        let instanceURLRequest  = instanceRequest.buildURLRequest()
        let instanceHeaders     = instanceURLRequest.allHTTPHeaderFields

        // ... but not for subsequent Request instances.
        // With no overrides, the default credentials of type .KeyAndToken should be returned:
        let defaultRequest     = Request("foo")
        let defaultURLRequest  = defaultRequest.buildURLRequest()
        let defaultHeaders     = defaultURLRequest.allHTTPHeaderFields
        
        XCTAssert(defaultHeaders?["X-Soracom-API-Key"] == defaultCredentials.apiKey)
        XCTAssert(defaultHeaders?["X-Soracom-API-Token"] == defaultCredentials.apiToken)
        
        XCTAssert(instanceHeaders?["X-Soracom-API-Key"] == instanceCredentials.apiKey)
        XCTAssert(instanceHeaders?["X-Soracom-API-Token"] == instanceCredentials.apiToken)
        
        // A global override should affect all Request instances:
        Request.credentialsFinder = { (req) in
            return globalCredentials
        }
        let globalRequest     = Request("foo")
        let globalURLRequest  = globalRequest.buildURLRequest()
        let globalHeaders     = globalURLRequest.allHTTPHeaderFields
        
        XCTAssert(globalHeaders?["X-Soracom-API-Key"] == globalCredentials.apiKey)
        XCTAssert(globalHeaders?["X-Soracom-API-Token"] == globalCredentials.apiToken)
        
        Request.credentialsFinder = nil // good test manners :)
    }
    
    
    func test_buildURL_and_endpoint() {
        
        let foo = Request("foo")
        
        XCTAssertEqual(foo.buildURL().absoluteString, "https://api-sandbox.soracom.io/v1/foo")
        
        let bar = Request("/bar")
        bar.endpoint = "http://stink.pot"
        bar.apiVersionString = ""
        XCTAssertEqual(bar.buildURL().absoluteString, "http://stink.pot/bar")
        bar.endpoint = "http://yes.no"
        XCTAssertEqual(bar.buildURL().absoluteString, "http://yes.no/bar")
    }
    
    
    func test_error_on_real_world_404() {
        
        let foo              = Request("/you-aint-no-valid-url-bruv")
        foo.apiVersionString = ""
        foo.endpoint         = "https://www.soracom.jp"
        foo.method           = .GET
        
        beginAsyncSection()
        
        foo.run { (response) in
            
            XCTAssertNotNil(response.error)
            XCTAssert(response.HTTPStatus == 404)
            // Mason 2016-04-12: we don't currently capture errors rendered as HTML so this is about as good as we can test for now.

            self.endAsyncSection()
        }
        waitForAsyncSection()
    }
    
    
    func test_set_credentials() {
        // Assert that setting credentials as if they were a regular property works.
        
        let defaultCredentials = SoracomCredentials(type: .KeyAndToken, emailAddress: "default@foo.bar")
        defaultCredentials.writeToSecurePersistentStorage()

        let req = Request("fake")
        
        XCTAssertEqual(req.credentials, defaultCredentials)
        
        let creds = SoracomCredentials(type: .RootAccount, emailAddress: "me@foo.bar")
        req.credentials = creds
        
        XCTAssertEqual(req.credentials, creds)
        
        // You cannot do this: req.credentials = nil
        // There is not really a reason to do this (vs just create a new request) but you can achieve the intention above by doing this:
        req.credentialsFinder = nil
        XCTAssertEqual(req.credentials, defaultCredentials)
    }
    
}
