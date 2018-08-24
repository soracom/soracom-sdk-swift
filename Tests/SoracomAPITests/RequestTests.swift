// RequestTests.swift Created by mason on 2016-03-20. Copyright © 2016 Soracom, Inc. All rights reserved.


import XCTest

@testable import SoracomAPI

class RequestTests: BaseTestCase {
    
    var originalCredentialsFinder: CredentialsFinder? = nil
    
    /// Overridden to set the default credentials storage namespace to `storageNamespaceForJunkCredentials`, becuase these tests write credentials as part of their work.
    
    override func setUp() {
        super.setUp()
        SoracomCredentials.defaultStorageNamespace = Client.sharedInstance.storageNamespaceForJunkCredentials
        
        originalCredentialsFinder = BaseRequest.credentialsFinder
        BaseRequest.credentialsFinder = nil;
    }
    
    override func tearDown() {
        super.tearDown()
        if (originalCredentialsFinder != nil) {
            BaseRequest.credentialsFinder = originalCredentialsFinder;
        }
    }
    

    func test_lookup_credentials_for_HTTP_headers() {
        // By default, Request will look up the "default" stored credentials of type SoracomCredentialType.KeyAndToken. However, the client
        // code may override that behavior by passing a function/closure to do the lookup. This can be done on a global or per-instance basis.
        
        let defaultCredentials  = SoracomCredentials(type: .KeyAndToken, emailAddress: "default@foo.bar", apiKey: "default", token: "default")
        let instanceCredentials = SoracomCredentials(type: .KeyAndToken, emailAddress: "instance@foo.bar", apiKey: "instance", token: "instance")
        let globalCredentials   = SoracomCredentials(type: .KeyAndToken, emailAddress: "global@foo.bar", apiKey: "global", token: "global")
        
        _ = defaultCredentials.save()
        
        // An instance-level override should override how credentials are looked up for that instance only...
        let instanceRequest     = Request<NoResponseBody>("/foo")
        instanceRequest.credentialsFinder = { (req) in
            return instanceCredentials
        }
        let instanceURLRequest  = instanceRequest.buildURLRequest()
        let instanceHeaders     = instanceURLRequest.allHTTPHeaderFields

        // ... but not for subsequent Request instances.
        // With no overrides, the default credentials should be used:
        let defaultRequest     = Request<NoResponseBody>("foo")
        let defaultURLRequest  = defaultRequest.buildURLRequest()
        let defaultHeaders     = defaultURLRequest.allHTTPHeaderFields
        
        XCTAssert(defaultHeaders?["X-Soracom-API-Key"] == defaultCredentials.apiKey)
        XCTAssert(defaultHeaders?["X-Soracom-Token"] == defaultCredentials.token)
        
        XCTAssert(instanceHeaders?["X-Soracom-API-Key"] == instanceCredentials.apiKey)
        XCTAssert(instanceHeaders?["X-Soracom-Token"] == instanceCredentials.token)
        
        // A global override should affect all Request instances:
        BaseRequest.credentialsFinder = { (req) in
            return globalCredentials
        }
        let globalRequest     = Request<NoResponseBody>("foo")
        let globalURLRequest  = globalRequest.buildURLRequest()
        let globalHeaders     = globalURLRequest.allHTTPHeaderFields
        
        XCTAssert(globalHeaders?["X-Soracom-API-Key"] == globalCredentials.apiKey)
        XCTAssert(globalHeaders?["X-Soracom-Token"] == globalCredentials.token)
        
        BaseRequest.credentialsFinder = nil // good test manners :)
    }
    
    
    func test_buildURL_and_endpointHost() {
        
        let foo = Request<NoResponseBody>("/foo")
        
        XCTAssertEqual(foo.buildURL().absoluteString, "https://api-sandbox.soracom.io/v1/foo")
        
        let bar              = Request<NoResponseBody>("/bar")
        bar.endpointHost     = "stink.pot"
        bar.apiVersionString = ""
        XCTAssertEqual(bar.buildURL().absoluteString, "https://stink.pot/bar")
        
        bar.endpointHost     = "yes.no"
        XCTAssertEqual(bar.buildURL().absoluteString, "https://yes.no/bar")
    }
    
    
    func test_error_on_real_world_404() {
        
        let foo              = Request<NoResponseBody>("/you-aint-no-valid-url-bruv")
        foo.apiVersionString = ""
        foo.endpointHost     = "www.soracom.jp"
        foo.method           = .get
        
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
        _ = defaultCredentials.save()

        let req = Request<NoResponseBody>("fake")
        
        XCTAssertEqual(req.credentials, defaultCredentials)
        
        let creds = SoracomCredentials(type: .RootAccount, emailAddress: "me@foo.bar")
        req.credentials = creds
        
        XCTAssertEqual(req.credentials, creds)
        
        // You cannot do this: req.credentials = nil
        // There is not really a reason to do this (vs just create a new request) but you can achieve the intention above by doing this:
        req.credentialsFinder = nil
        XCTAssertEqual(req.credentials, defaultCredentials)
    }
    
    
    func test_attached_behaviors() {
        
        var accumulator: [String] = []
        
        BaseRequest.beforeRun { (request) in
            accumulator.append("beforeRun")
        }
        
        BaseRequest.afterRun { (request) in
            accumulator.append("afterRun")
        }
        
        let req = Request<NoResponseBody>("fake")

        beginAsyncSection()
        req.run { (response) in
            accumulator.append("response handler")
            self.endAsyncSection()
        }
        waitForAsyncSection()
        
        XCTAssertEqual(accumulator, ["beforeRun", "afterRun", "response handler"])
    }
    
    
    func test_response_handler_precedence() {
        
        beginAsyncSection()
        
        let expectation1 = expectation(description: "uno")
        let expectation2 = expectation(description: "dos")

        var values: [String] = []
        
        let req1 = Request<NoResponseBody>("fake") { (response) in
            values.append("req1 initial instance responseHandler ran")
            expectation1.fulfill()
        }
        
        let req2 = Request<NoResponseBody>("fake") { (response) in
            values.append("req2 initial instance responseHandler ran")
            expectation2.fulfill()
        }
        req2.responseHandler = { (response) in
            values.append("req2 modified responseHandler ran")
            expectation2.fulfill()
        }
        
        let req3 = Request<NoResponseBody>("fake") { (response) in
            values.append("req3 instance responseHandler ran")
        }
        
        req1.run()
        req2.run()
        req3.run { (response) in
            values.append("req3 run method argument responseHandler ran")
            self.endAsyncSection()
        }
        
        waitForAsyncSection()
        
        let expected = [
            "req1 initial instance responseHandler ran",
            "req2 modified responseHandler ran",
            "req3 run method argument responseHandler ran"
        ]
        
        // XCTAssertEqual(values, expected)
        // Nope that fails like this sometimes, due to race condition (each run() call spawns a subthread, and occasionally a thread created later finishes earlier):
        // XCTAssertEqual failed: ("["req1 initial instance responseHandler ran", "req3 run method argument responseHandler ran", "req2 modified responseHandler ran"]") is not equal to ("["req1 initial instance responseHandler ran", "req2 modified responseHandler ran", "req3 run method argument responseHandler ran"]")
        // Instead:
        
        for x in expected {
            XCTAssert(values.contains(x))
        }
    }
    
    
    func test_wait() {
        
        // this test just proves that wait() doesn't block, but does return a value
        
        let req1 = Request.createSandboxSubscriber()
        let req2 = Request.createSandboxSubscriber()
        
        let response1 = req1.wait()
        XCTAssertNotNil(response1)

        let response2 = req2.wait()
        XCTAssertNotNil(response2)
    }
    
}

#if os(Linux)
    extension RequestTests {
        static var allTests : [(String, (RequestTests) -> () throws -> Void)] {
            return [
                ("test_lookup_credentials_for_HTTP_headers", test_lookup_credentials_for_HTTP_headers),
                ("test_buildURL_and_endpointHost", test_buildURL_and_endpointHost),
                ("test_error_on_real_world_404", test_error_on_real_world_404),
                ("test_set_credentials", test_set_credentials),
                ("test_attached_behaviors", test_attached_behaviors),
                ("test_response_handler_precedence", test_response_handler_precedence),
                ("test_wait", test_wait),
            ]
        }
    }
#endif

