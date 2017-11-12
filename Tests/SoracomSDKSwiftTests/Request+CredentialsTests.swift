// Request+CredentialsTests.swift Created by mason on 2016-04-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

#if os(Linux)
    @testable import SoracomSDKSwift
#endif

class RequestCredentialsTests: BaseTestCase {
    
    override func setUp() {
        
        super.setUp()
        
        self.continueAfterFailure = false
        
        guard !Client.sharedInstance.credentialsForSandboxUser.blank else {
            // API Sandbox user can be created automatically as needed, but only
            // if production SAM user credentials have been stored.
            // For the SDK demo apps, you can use the GUI to save these credentials;
            // otherwise, you can do it in the debugger.
            //
            // See Client.doInitialHousekeeping() for details
            
            XCTFail("Cannot run \(self) because no credentials are available. See test method comments for details.")
            
            return
        }
    }
    
    
    /// Multi step CRUD test.
    
    func test_CRUD_credentials() {
        
        let junk    = UUID().uuidString
        let creds   = Credentials(accessKeyId: "foo", secretAccessKey: "bar")
        var options = CredentialOptions(type: "aws-credentials", description: "test_CRUD_credentials", credentials: creds)
        
        // CREATE:
        let createRequest  = Request.createCredential(id: junk, options: options)
        let createResponse = createRequest.wait()
        
        XCTAssertNil(createResponse.error)
        
        let created = Credential.from(createResponse.payload)
        
        XCTAssertNotNil(created)
        XCTAssertNotNil(created?.credentials)
        XCTAssertEqual("test_CRUD_credentials", created?.description)
        XCTAssertEqual("foo", created?.credentials?.accessKeyId)
        XCTAssertEqual(junk, created?.credentialsId)
        
        XCTAssertNotNil(findCredential(junk))
        
        options.description = "updated description"
        
        // UPDATE:
        let updateRequest  = Request.updateCredential(id: junk, options: options)
        let updateResponse = updateRequest.wait()
        
        XCTAssertNil(updateResponse.error)
        
        let updated = findCredential(junk)
        XCTAssertEqual("updated description", updated?.description)
        
        // DELETE:
        let deleteRequest  = Request.deleteCredential(id: junk)
        let deleteResponse = deleteRequest.wait()
        
        XCTAssertNil(deleteResponse.error)
        XCTAssertNil(findCredential(junk))
    }
    
    
    func listCredentials() -> [Credential]? {
        
        let listRequest  = Request.listCredentials()
        let listResponse = listRequest.wait()
        
        guard let credList = Credential.listFrom(listResponse.payload) else {
            XCTFail()
            return nil
        }
        
        return credList
    }
    
    
    func findCredential(_ id: String) -> Credential? {
        
        guard let list = listCredentials() else {
            XCTFail()
            return nil
        }
        
        var found: Credential? = nil
        
        for cred in list {
            if cred.credentialsId == id {
                found = cred
                break
            }
        }
        return found
    }

}

#if os(Linux)
    extension RequestCredentialsTests {
        static var allTests : [(String, (RequestCredentialsTests) -> () throws -> Void)] {
            return [
                ("test_CRUD_credentials", test_CRUD_credentials),
            ]
        }
    }
#endif

