// Request+SandboxAPITests.swift Created by mason on 2016-04-12. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class RequestSandboxTests: BaseTestCase {
    
    
    func test_getSignupToken_bad_credentials() {
    
        let uniqueEmail = "\(NSUUID().UUIDString)@fivespeed.com"
        let badRequest  = Request.getSignupToken(email: uniqueEmail, authKeyId: "this-is-wrong", authKey: "this-is-also-wrong")
        
        beginAsyncSection()
        
        badRequest.run { (response) in
            
            print(response)
            XCTAssertNotNil(response.error)
            
            let code = response.error?.code ?? "no code"
            XCTAssert(code.containsString("SBX"))
              // Just assert it is some kind of sandbox error.
            
            self.endAsyncSection()
        }
        
        waitForAsyncSection()
    }
    
    
    func test_createOperator_then_getSignupToken() {
        
        // For this test, we need the credentials for a SAM user from the real production environment.
        
        guard let credentials = credentialsForTestUse(.AuthKey, production: true) else {
            // To add credentials, set a breakpoint here and do this (see notes in method documentation):
            // saveProductionAuthKeyCredentialsForTests(authKeyID: "xxxxxx", authKeySecret: "xxxxxx")
            
            print ("skipping \(#function) because no credentials are available.")
            return
        }
        
        self.continueAfterFailure = false
        
        let uniqueEmail    = "\(NSUUID().UUIDString)@fivespeed.com"
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
            
            let fast  = AirStatsForSpeedClass(uploadBytes: 0, uploadPackets: 0, downloadBytes: 0, downloadPackets: 0)
            
            let nowInterval = NSDate().timeIntervalSince1970
            let nowInt   = Int64(nowInterval)
            let now = nowInt * 1000
            // Mason 2016-03-23: Building for iOS, get this: exc_bad_instruction (code=exc_i386_invop subcode=0x0)
            // Because type was just Int. Oopsie! Forgot there are still 32-bit platforms? :-/
            
            let stats = AirStats(traffic: [.s1_fast: fast, .s1_slow: fast, .s1_minimum: fast, .s1_standard: fast], unixtime: now)
            
            Request.insertAirStats(imsi, stats: stats).run() { (response) in
                XCTAssert(response.error == nil)
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
                XCTAssert(imsi.characters.count > 10)
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
