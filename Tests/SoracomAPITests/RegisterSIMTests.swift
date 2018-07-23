//  RegisterSIMTests.swift Created by mason on 2016-03-12. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if !SKIP_TESTABLE_IMPORT_FOR_TESTS
@testable import SoracomAPI
#endif

class RegisterSIMTests: BaseTestCase {

    
    func testSimulatedSIMRegistrationCompleteProcess() {
        
        let sandboxCredentials = Client.sharedInstance.credentialsForSandboxUser
        
        guard !sandboxCredentials.blank else {
            // This test has to have the production SAM user credentials, because it makes a new unique sandbox user.
            // For the SDK demo apps, you can use the GUI to save these credentials; otherwise, you can do it in the debugger. See Client.doInitialHousekeeping() for details
            
            XCTFail("Cannot run \(#function) because no production SAM user credentials are available. See test method comments for more info.")
            
            return
        }
        
        self.continueAfterFailure = false
          // This is a sequential process we are testing, so we should fail as soon as any step fails.
        
        let subscriber = createSandboxSubscriber()
          // 5 Create dummy Subscriber (SIM).
        
        registerSubscriber(subscriber.IMSI, registrationSecret: subscriber.registrationSecret)
          // Finally, register the SIM!
        
        updateSpeedClass(subscriber.IMSI, speedClass: .s1_fast)
        
        let list = listSubscribers()
        
        XCTAssert(list.count > 0) // FIXME: find it by IMSI, don't be so lazy
        
        getSubscriber(subscriber.IMSI)
    }
    
    
    /// Create dummy SIM.
    
    func createSandboxSubscriber() -> (IMSI: String, registrationSecret: String) {
        
        _ = beginAsyncSection()
        
        var IMSI = "BOGUS"
        var registrationSecret = "BOGUS"
        
        let req = Request.createSandboxSubscriber()
        req.run { (response) in
            
            print(response)
            print(response.payload ?? "(response.payload == nil)")
            
            // Payload looks like:
            // [
            //      "msisdn": 999923082204,
            //      "tags": {},
            //      "registrationSecret": 98025,
            //      "operatorId": OP9999999999,
            //      "moduleType": nano,
            //      "imsi": 001011722653275,
            //      "ipAddress": 10.126.200.74,
            //      "apn": soracom-sandbox.io,
            //      "serialNumber": TS6637374886777,
            //      "sessionStatus": { "online" : 0 },
            //      "type": s1.standard
            //  ]
            //
            // For now we just grab the IMSI and registrationSecret.
            
            guard let payload = response.payload else {
                XCTFail("expected payload")
                return
            }
            
            IMSI = payload[.imsi] as? String ?? "BOGUS"
            registrationSecret = payload[.registrationSecret] as? String ?? "BOGUS"
            
            XCTAssert(response.error == nil)
            
            self.endAsyncSection()
        }
        waitForAsyncSection()
        
        return (IMSI: IMSI, registrationSecret: registrationSecret)
    }
    
    
    /// Register the dummy SIM.
    
    func registerSubscriber(_ imsi: String, registrationSecret: String) {
        
        _ = beginAsyncSection()
        
        let req = Request.registerSubscriber(imsi, registrationSecret: registrationSecret)
        req.run { (response) in
            
            print(response)
            print(response.payload ?? "(response.payload == nil)")
            
            XCTAssert(response.error == nil)
            
            self.endAsyncSection()
        }
        waitForAsyncSection()
        
        // FIXME: someday return a Subscriber struct here. I haven't created the Subscriber struct yet though.
    }
    
    
    /// Update the speed class.
    
    func updateSpeedClass(_ imsi: String, speedClass: SpeedClass) {

        _ = beginAsyncSection()
        
        let req = Request.updateSpeedClass(imsi, speedClass: speedClass)
        
        req.run { (response) in
            XCTAssert(response.error == nil)
            self.endAsyncSection()
        }
        waitForAsyncSection()
    }
    
    
    /// Get the list of subscribers (will be a list of at least, but could be more since user can manually use sandbox user).
    
    func listSubscribers() -> [Subscriber] {
        
        _ = beginAsyncSection()
        
        let req = Request.listSubscribers(speedClassFilter: [.s1_fast], limit: 999);
        
        var result: [Subscriber] = []
        
        req.run { (response) in
        
            XCTAssert(response.error == nil)
            
            if let payload = response.payload, let list = Subscriber.listFrom(payload) {
                result.append(contentsOf: list)
            } else {
                XCTFail("could not get subscriber list")
            }
            
            self.endAsyncSection()
        }
        waitForAsyncSection()
        
        return result
    }
    
    
    /// Get the record for the single subscriber referenced by `imsi`.
    
    func getSubscriber(_ imsi: String?) {
        
        guard let imsi = imsi else {
            XCTFail("test expectation failure: didn't get IMSI")
            return
        }
        
        _ = beginAsyncSection()
        
        let req = Request.getSubscriber(imsi)
        
        req.run { (response) in
            
            XCTAssert(response.error == nil)
            
            if let subscriber = Subscriber.from(response.payload) {
                
                XCTAssert(subscriber.imsi == imsi)
                XCTAssert(subscriber.speedClass == SpeedClass.s1_fast.rawValue)
                  // beacause we set this in previous step
            
            } else {
                XCTFail("didn't get subscriber record")
            }
            
            self.endAsyncSection()
        }

        waitForAsyncSection()
    }
}


#if os(Linux)
    extension RegisterSIMTests {
        static var allTests : [(String, (RegisterSIMTests) -> () throws -> Void)] {
            return [
                ("testSimulatedSIMRegistrationCompleteProcess", testSimulatedSIMRegistrationCompleteProcess),
            ]
        }
    }
#endif 

