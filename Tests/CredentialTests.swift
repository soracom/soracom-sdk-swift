// CredentialTests.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class CredentialTests: BaseTestCase {
    
    func test_serialize() {
        let c  = Credential(description: "my awesome credential bro")
        
        guard let c2 = roundTripSerializeDeserialize(c) as? Credential else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(c2.description,  "my awesome credential bro")
    }
    
    
    func test_serialize_list() {
        
        let a  = Credential(description: "awesome credential")
        let b  = Credential(description: "bodacious credential")
        let c  = Credential(description: "consummate credential")
        
        let outgoing = Payload(list: [a,b,c])
        let incoming = roundTripSerializeDeserialize(outgoing)
        
        guard let list = Credential.listFrom(incoming) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(list[0].description, "awesome credential")
        XCTAssertEqual(list[1].description, "bodacious credential")
        XCTAssertEqual(list[2].description, "consummate credential")
    }
    
}
