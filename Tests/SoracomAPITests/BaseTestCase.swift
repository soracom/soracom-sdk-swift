// BaseTestCase.swift Created by mason on 2016-03-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest


#if USE_TESTABLE_IMPORT_FOR_MAC_DEMO_APP
    // Do nothing (it's magic). We unfortunately need 3 different import 
    // modes: Xcode+macOS, Xcode+iOS, and non-Xcode ("swift test" CLI) 
    // due to macOS and iOS not supporting SPM build/test...

#elseif USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomSDK

#else
    @testable import SoracomAPI 
#endif

#if os(Linux)
    import Dispatch
#endif


var oneTimeTestSetupToken: Int  = 0

/// A base class that implements some common conveniences/hacks for the project's tests. e.g. making async tests require less boilerplate.

class BaseTestCase: XCTestCase {

    private static var __once: () = {
        
        //        Request.beforeRun { (request) in
        //            print(request)
        //        }
        //        Request.afterRun { (response) in
        //            print(response)
        //        }
        //
        // (UNCOMMMENT ABOVE TO DEBUG ALL REQUESTS AND RESPONSES WHILE TESTS RUN)
        
        Client.sharedInstance.doInitialHousekeeping()
          // This is done here to allow setting up credentials for tests to use to run tests against
          // the API Sandbox. See the implmentation for details. You can enter credentials using lldb.

        
        print("------------------------------")
        print("--- BaseTestCase will now attempt to set up the testing environment for this test run.")
        print("--- ✅ Set the app-wide default storage namespace to BaseTestCase.storageNamespaceForSandboxCredentials.")

        var shouldCreateNewSandboxUser = false
        let existingSandboxCredentials = Client.sharedInstance.credentialsForSandboxUser
        
        if existingSandboxCredentials.blank {
            
            shouldCreateNewSandboxUser = true
        
        } else {
            
            let authRequest  = Request.auth(existingSandboxCredentials)
            let authResponse = authRequest.wait()
            
            // If we get an error here, it might be AUM0002 "Invalid username/password supplied."
            // This can be expected to happen frequently, because API Sandbox credentials
            // periodically expire (weekly?).
            //
            // Therefore we should try to make a new sandbox user and auth with it here. If THAT
            // fails, then something else is wrong and we can't fix it here.
            
            if authResponse.error?.code == "AUM0002" {
                shouldCreateNewSandboxUser = true
            }
        }
        
        if shouldCreateNewSandboxUser {
            
            let existingProductionCredentials = Client.sharedInstance.credentialsForProductionSAMUser
            
            if !existingProductionCredentials.blank {
                
                if let newSandboxCredentials = Client.sharedInstance.synchronousCreateSandboxUser(existingProductionCredentials) {
                    
                    //SoracomCredentials.sandboxCredentials = newSandboxCredentials
                    Client.sharedInstance.saveCredentials(newSandboxCredentials, user: .APISandboxUser)
                    
                } else {
                    print("--- ")
                    print("--- ⚠️ Unable to automatically create an API sandbox user. This probably means")
                    print("--- that the stored production SAM user credentials are not valid. This problem")
                    print("--- cannot be fixed automatically. Try using the demo app to save new credentials.")
                }
            }
        }
        
        // Many tests need a valid API key/token, and those expire, so we should update even if we have credentials:
        
        if let creds = Client.sharedInstance.synchronousUpdateToken(Client.sharedInstance.credentialsForSandboxUser) {
        
            Client.sharedInstance.saveCredentials(creds, user: .APISandboxUser)
            
            print("--- ")
            print("--- ✅ Sandbox user \(creds.emailAddress) can authenticate, and will be used to run tests.")
            print("--- ")

        } else {
        
            print("--- ")
            print("--- ⚠️ There are no stored API sandbox credentials. This is OK, but it means")
            print("--- many tests will not run.")
            print("--- ")
            print("--- Note that one easy way to store API sandbox credentials is to run the demo app ")
            print("--- and use the GUI to create a sandbox user. The credentials for that sandbox user ")
            print("--- will be stored securely, and used for the tests that need a sandbox user to run. ")
            print("--- ")
        }
        
        print("------------------------------")
    }()

    /// We override `setUp()` to:
    ///
    /// - set the default credentials storage namespace to `BaseTestCase.storageNamespaceForSandboxCredentials`. This lets the tests fetch and use a unique set of credentials. Tests that **write** credentials as part of their testing should do a similar thing, so they do not clobber the credentials used by other tests.
    /// 
    /// - run some one-time setup code that tries to log in to the API sandbox using those credentials, to fetch an expiring API Key and API Token, which is needed for most tests that exercise the API.
    
    override func setUp() {
        
        super.setUp()
        
        SoracomCredentials.defaultStorageNamespace = Client.sharedInstance.storageNamespaceForSandboxCredentials
        _ = BaseTestCase.__once
    }
    
    
    // MARK: - Round-trip serialization testing conveniences
    
    /// Encode`payload` as JSON, then initializes a new Payload instance with that JSON data. Asserts the newly-decoded payload emits identical JSON, failing otherwise. Returns the new decoded Payload instance. (This is a convenience for writing tests for model object serialization.)
    
    func roundTripSerializeDeserialize(_ payload: Payload, caller: StaticString = #function) -> Payload? {
        
        guard let data = payload.toJSONData() else {
            XCTFail("roundTripSerializeDeserialize: failed to encode: \(payload)")
            return nil
        }
        
        guard let decodedPayload = try? Payload(data: data) else {
            XCTFail("roundTripSerializeDeserialize: failed to decode: \(data.utf8String ?? "no JSON!")")
            return nil
        }
        
        // Mason 2016-08-02: If testing for binary identicality ever becomes an issue causing spurious failures, convert to isEquivalentJSON() like below.
        XCTAssertEqual(data, decodedPayload?.toJSONData())
        
        return decodedPayload
    }
    
    
    /// Encodes `obj` as a Payload, converts that to JSON data, creates a new Payload by decoding that JSON data, instantiates a new object from that new payload, and returns it. (This is a convenience for writing tests for model object serialization.) Explicitly doesn't allow comparison of `Payload` objects which fail to encode (i.e. where `toJSONData()` returns `nil`).
    
    func roundTripSerializeDeserialize(_ obj: Codable) -> Codable? {
        
        let payload = obj.toPayload()
        
        guard let data = payload.toJSONData() else {
            XCTFail()
            return nil
        }

        guard let decodedPayload = try? Payload(data: data) else {
            XCTFail()
            return nil
        }
        
        guard let decodedObject = type(of: obj).from(decodedPayload) else {
            XCTFail()
            return nil
        }
        
        // XCTAssertEqual(decodedObject.toPayload().toJSONData(), data)
        //
        // I no longer do this because key order is not deterministic, or at least I
        // don't know what determines that order, and this caused spurious failures.
        // Instead:
        
        guard let data2 = decodedObject.toPayload().toJSONData() else {
            XCTFail()
            return nil
        }
        
        guard let json  = String(data: data, encoding: .utf8),
              let json2 = String(data: data2, encoding: .utf8)
        else {
            XCTFail()
            return nil
        }
        
        XCTAssertTrue(isEquivalentJSON(json, json2))
        
        return decodedObject
    }
    
    
    // MARK: - Asychronous testing conveniences
    // These are intended to make our normal async test pattern slightly more convenient.
    
    private var asyncSectionExpectation: [String: XCTestExpectation] = [:]
    
    
    /// Creates a test expectation, the same as XCTestCase's `expectationWithDescription()` does. The difference is that it stores the expectation, so keeping the expectation object around in a variable in the test case isn't required. Normally, you end the async section (i.e., fulfill the expectation) by calling `self.endAsyncSection()` from within the async block. **Note:** This method used to return the expectation, so that you could capture it and fulfill it the normal XCTestCase way, if you for some reason want to avoid capturing self in the async block. But, ignoring return values became more annoying in Swift 3, so this was changed. Now it just stashes the newly-created expectation in `self.asyncSectionExpectation`, so if you really need it (not normally true) you have to get it from there.
    
    func beginAsyncSection(_ description: String = #function) {
        let expectation = self.expectation(description: description)
        asyncSectionExpectation["\(description)"] = expectation
    }
    
    
    func endAsyncSection(_ description: String = #function) {
        guard let ex = asyncSectionExpectation["\(description)"] else {
            fatalError("Ooops! Your async tests seem fubared.")
        }
        ex.fulfill()
    }
    
    
    func waitForAsyncSection(_ description: String = #function, timeout: TimeInterval = 60.0) {
        waitForExpectations(timeout: timeout) { error in
            if let error = error {
                print( "waitForExpectationsWithTimeout got error: \(error.localizedDescription)")
            }
        }
    }
    
    
    // MARK: - General utility functions
        
    /// Compares JSON strings, ignoring key order, whitespace, etc. Returns true if the decoded objects are logically equivalent, otherwise false. Supports booleans, integers, strings, arrays, and objects. (Arrays and objects may only contain these five types.)
    
    func isEquivalentJSON(_ lhs: String, _ rhs: String) -> Bool {
        
        guard let lData = lhs.data(using: .utf8),
              let rData = rhs.data(using: .utf8),
              let obj1  = try? JSONSerialization.jsonObject(with: lData, options: []),
              let obj2  = try? JSONSerialization.jsonObject(with: rData, options: [])
        else {
                XCTFail("isEquivalentJSON() only works with two valid JSON strings; will now call XCTFail() and return false. ")
                return false
        }
        return isEquivalentJSONValue(obj1, obj2)
    }
    
    
    /// I'm a bit drunk... 🍻
    
    func isEquivalentJSONValue(_ lhs: Any?, _ rhs: Any?) -> Bool {
        
        if lhs == nil || rhs == nil {
            XCTFail("WTF error for equivBro values: \(String(describing: lhs)) and \(String(describing: rhs))")
            return false;
        }        
        return JSONComparison.areEquivalentJSONValues(lhs, rhs)
    }

    
    /// Convenience method to get a new IMSI from the API sandbox, before running your actual tests. You still need to set up expectations in your main test method body. Example:
    ///
    ///     let expectation = beginAsyncSection()
    ///
    ///     withNewIMSI { (imsi) in
    ///         // do your test here
    ///         self.endAsyncSection()
    ///     }
    ///     waitForAsyncSection()
    
    func withNewIMSI(_ handler: @escaping (_ imsi: String) -> ()) {
        Request.createSandboxSubscriber().run { (response) in
            XCTAssert(response.error == nil)
            if let imsi = response.payload?[.imsi] as? String {
                handler(imsi)
            } else {
                XCTFail("withNewIMSI() could not get new IMSI")
            }
        }
    }
    
}
