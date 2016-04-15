// Request+CredentialsAPITests.swift Created by mason on 2016-04-12. Copyright © 2016 Soracom, Inc. All rights reserved.

class RequestCredentialsAPITests
{
    //    // MARK: CREDENTIALS API
    //    
    //    func DISABLED_test_listCredentials() {
    //        beginAsyncSection()
    //        
    //        Request.listCredentials().run { (result) in
    //            print(result)
    //            
    //            print(result.payload)
    //            
    //            // Mason 2016-03-23: I get some kind of pathological behavior here... it takes 30+ sec, then this error result:
    //            //
    //            //            Response {
    //            //                HTTP status:  500
    //            //                In response to: GET https://api-sandbox.soracom.io/v1/credentials
    //            //                HTTP headers: {
    //            //                    Content-Type: text/plain; charset=utf-8
    //            //                    Content-Length: 46
    //            //                    Connection: keep-alive
    //            //                    Date: Wed, 23 Mar 2016 05:11:43 GMT
    //            //                }
    //            //                Data (as UTF-8): 【{"code":"AGW0005", "message":"Internal error"}】
    //            //            }
    //            
    //            XCTAssert(result.error == nil)
    //            self.endAsyncSection()
    //        }
    //        
    //        confirm(60.0)
    //    }
    //    
    //    
    //    func DISABLED_test_createCredential() {
    //        beginAsyncSection()
    //        
    //        let cred = Credential()
    //        Request.createCredential(cred).run { (result) in
    //            
    //            print(result)
    //            print("did it blend?")
    //            
    //            XCTAssert(result.error == nil)
    //            // Mason 2016-03-23: this also gets {"code":"AGW0005", "message":"Internal error"} every time. Deferring...
    //            
    //            self.endAsyncSection()
    //        }
    //        confirm(60.0)
    //        
    //    }

}