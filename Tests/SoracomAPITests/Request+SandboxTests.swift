// Request+SandboxAPITests.swift Created by mason on 2016-04-12. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
@testable import SoracomAPI
#endif

class RequestSandboxTests: BaseTestCase {
    
    
    func test_getSignupToken_bad_credentials() {
    
        let uniqueEmail = "\(UUID().uuidString)@fivespeed.com"
        let badRequest  = Request.getSignupToken(email: uniqueEmail, authKeyId: "this-is-wrong", authKey: "this-is-also-wrong")
        
        beginAsyncSection()
        
        badRequest.run { (response) in
            
            print(response)
            XCTAssertNotNil(response.error)
            
            let code = response.error?.code ?? "no code"
            XCTAssert(code.contains("SBX"))
              // Just assert it is some kind of sandbox error.
            
            self.endAsyncSection()
        }
        
        waitForAsyncSection()
    }
    
    
    func test_createOperator_then_getSignupToken() {
        
        // For this test, we need the credentials for a SAM user from the real production environment.
        
        let credentials = Client.sharedInstance.credentialsForProductionSAMUser
        
        guard !credentials.blank else {
            // API Sandbox user can be created automatically as needed, but only if production SAM user credentials have been stored.
            // For the SDK demo apps, you can use the GUI to save these credentials; otherwise, you can do it in the debugger. See Client.doInitialHousekeeping() for details

            XCTFail("Cannot run \(#function) because no credentials are available. See comments in the test method for more info.")
            return
        }
        
        self.continueAfterFailure = false
        
        let uniqueEmail    = "\(UUID().uuidString)@fivespeed.com"
        let uniquePassword = "(NSUUID().UUIDString)a$d5555"
        
        
        // CREATE THE OPERATOR:
        
        beginAsyncSection()
        
        Request.createOperator(uniqueEmail, password: uniquePassword).run { (response) in
            
            print(response)
            
            XCTAssertNil(response.error)
            
            self.endAsyncSection()
        }
        waitForAsyncSection()
        
       
        // AUTHORIZE CREATION OF, AND CREATE, A SIGNUP TOKEN:
        
        let req = Request.getSignupToken(email: uniqueEmail, authKeyId: credentials.authKeyID, authKey: credentials.authKeySecret)
        
        beginAsyncSection()

        req.run { (response) in
            print(response)
            
            XCTAssertNil(response.error)
            
            let token = response.payload?[.token]
            XCTAssertNotNil(token)
            
            self.endAsyncSection()
            
            // One possibility: {"code":"SBX1003","message":"Unable to get verified one time token. please create an user at first"}】
        }
        waitForAsyncSection()
    }
    
    
    func test_deleteSandboxOperator_error() {
        
        beginAsyncSection()
        
        let req = Request.deleteSandboxOperator("butt")
        req.run { (response) in
            
            print(response)
            
            XCTAssert(response.error != nil)
            XCTAssert(response.HTTPStatus == 400)
            
            self.endAsyncSection()
        }
        waitForAsyncSection()
    }
    
    
    func test_insertAirStats() {

        beginAsyncSection()

        withNewIMSI { (imsi) in
            
            let trafficStats = DataTrafficStats(downloadByteSizeTotal: 0, downloadPacketSizeTotal: 0, uploadByteSizeTotal: 0, uploadPacketSizeTotal: 0)
            
            let nowInterval = Date().timeIntervalSince1970
            let nowInt   = Int(nowInterval)
            let now = nowInt * 1000
            // Mason 2016-03-23: Building for iOS, get this: exc_bad_instruction (code=exc_i386_invop subcode=0x0)
            // Because type was just Int. Oopsie! Forgot there are still 32-bit platforms? :-/
            // UPDATE 2017-07-26: We decided in the end not to support 32-bit platforms.
            
            let map = DataTrafficStatsMap(s1_fast: trafficStats, s1_minimum: trafficStats, s1_slow: trafficStats, s1_standard: trafficStats)

            let airStats = AirStats(dataTrafficStatsMap: map, unixtime: now)
            
            Request.insertAirStats(imsi, stats: airStats).run() { (response) in
                XCTAssertNil(response.error)
                self.endAsyncSection()
            }
        }
        waitForAsyncSection()
    }


    func test_createSandboxSubscriber() {
        
        beginAsyncSection()
        
        Request.createSandboxSubscriber().run { (response) in
            
            XCTAssert(response.error == nil)
            
            if let imsi = response.payload?[.imsi] as? String {
                XCTAssert(imsi.count > 10)
            } else {
                XCTFail("Could not get IMSI")
            }
            self.endAsyncSection()
        }
        waitForAsyncSection()
    }
    
    
    func test_insertBeamStats() {
        
        let time      = 0
        let beamStats = BeamStats(inHttp: 1, inMqtt: 2, inTcp: 3, inUdp: 4, outHttp: 5, outHttps: 6, outMqtt: 7, outMqtts: 8, outTcp: 9, outTcps: 10, outUdp: 11)
        let toInsert  = BeamStatsInsertion(beamStats: beamStats, unixtime: time)

        beginAsyncSection()

        withNewIMSI { (imsi) in
            
            let req = Request.insertBeamStats(imsi, stats: toInsert)
            
            req.run { (response) in
                print(response)
                
                XCTAssert(response.error == nil)
                XCTAssert(response.HTTPStatus == 200)
                
                self.endAsyncSection()
            }
        }
        waitForAsyncSection()
    }
    
    
    func test_createSandboxCoupon() {

        beginAsyncSection()

        withNewIMSI { (imsi) in
            
            let req = Request.createSandboxCoupon(100, balance: 100, billItemName: "what", couponCode: "YUCK-FOU", expiryYearMonth: "201609")
            
            req.run { (response) in
                
                XCTAssert(response.error == nil)
                XCTAssert(response.HTTPStatus == 200)
                self.endAsyncSection()
            }
        }
        waitForAsyncSection()
    }

}

#if os(Linux)
    extension RequestSandboxTests {
        static var allTests : [(String, (RequestSandboxTests) -> () throws -> Void)] {
            return [
                ("test_getSignupToken_bad_credentials", test_getSignupToken_bad_credentials),
                ("test_createOperator_then_getSignupToken", test_createOperator_then_getSignupToken),
                ("test_deleteSandboxOperator_error", test_deleteSandboxOperator_error),
                ("test_insertAirStats", test_insertAirStats),
                ("test_createSandboxSubscriber", test_createSandboxSubscriber),
                ("test_insertBeamStats", test_insertBeamStats),
                ("test_createSandboxCoupon", test_createSandboxCoupon),
            ]
        }
    }
#endif


