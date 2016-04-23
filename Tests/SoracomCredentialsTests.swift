// SoracomCredentialsTests.swift Created by mason on 2016-02-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

class SoracomCredentialsTests: BaseTestCase {
    
    /// Overridden to set the default credentials storage namespace to `storageNamespaceForJunkCredentials`, because these tests exercise the actual credentials read/write API.
    
    override func setUp() {
        super.setUp()
        SoracomCredentials.defaultStorageNamespace = storageNamespaceForJunkCredentials
    }
    
    
    var one = SoracomCredentials(type: .RootAccount, emailAddress: "one", operatorID: "one", username: "one", password: "one", authKeyID: "one", authKeySecret: "one", apiKey: "one", apiToken: "one")
    
    var two = SoracomCredentials(type: .SAM, emailAddress: "two", operatorID: "two", username: "two", password: "two", authKeyID: "two", authKeySecret: "two", apiKey: "two", apiToken: "two")
    
    var testValues = [
        "type"          : "type value",
        "emailAddress"  : "emailAddress value",
        "operatorID"    : "operatorID value",
        "username"      : "username value",
        "password"      : "password value",
        "authKeyID"     : "authKeyID value",
        "authKeySecret" : "authKeySecret value",
        "apiKey"        : "apiKey value",
        "apiToken"      : "apiToken value",
    ]
    
    
    func test_store_in_keychain_original() {
        
        one.writeToSecurePersistentStorage()
        two = SoracomCredentials(withStorageIdentifier: nil)
        
        XCTAssert(two == one)
    }
    
    
    func test_writeToSecurePersistentStorage() {
        
        // Each of the 4 types of credentials has an associated default key under which is is persisted to the Keychain.
        
        let rootCredentials    = SoracomCredentials(type: .RootAccount, emailAddress: "root@root.root")
        let samCredentials     = SoracomCredentials(type: .SAM, emailAddress: "sam@sam.sam")
        let authKeyCredentials = SoracomCredentials(type: .AuthKey, emailAddress: "authkey@authkey.authkey")
        let tokenCredentials   = SoracomCredentials(type: .KeyAndToken, emailAddress: "token@token.token")
        
        let allCredentials     = [rootCredentials, samCredentials, authKeyCredentials, tokenCredentials]
        
        for c in allCredentials {
            let stored = c.writeToSecurePersistentStorage()
            XCTAssertTrue(stored)
            
            let defaultCredentials = SoracomCredentials(withStorageIdentifier: nil)
            XCTAssert(defaultCredentials == c)
        }
        
        for c in allCredentials {
            let type = c.type
            let read = SoracomCredentials(withStoredType: type)
            
            XCTAssert(read == c)
        }
    }
    
    
    func test_serialization_roundtrip() {
        
        let encoded = one.dictionaryRepresentation()
        let decoded = SoracomCredentials.init(withDictionary: encoded)
        
        XCTAssert(decoded == one)
    }
    
    
    func test_deserialization() {
        
        let foo = SoracomCredentials.init(withDictionary: testValues)
        
        XCTAssert(foo.type == .RootAccount)
          // because bogus val should be ignored for this prop, and .RootAccount should be default
        
        XCTAssert(foo.emailAddress == "emailAddress value")
        XCTAssert(foo.operatorID == "operatorID value")
        XCTAssert(foo.username == "username value")
        XCTAssert(foo.password == "password value")
        XCTAssert(foo.authKeyID == "authKeyID value")
        XCTAssert(foo.authKeySecret == "authKeySecret value")
        XCTAssert(foo.apiKey == "apiKey value")
        XCTAssert(foo.apiToken == "apiToken value")
        
        let bar = SoracomCredentials.init(withDictionary: [:])
        XCTAssert(bar.type == .RootAccount)
        XCTAssert(bar.emailAddress == "")
        XCTAssert(bar.operatorID == "")
        XCTAssert(bar.username == "")
        XCTAssert(bar.password == "")
        XCTAssert(bar.authKeyID == "")
        XCTAssert(bar.authKeySecret == "")
        XCTAssert(bar.apiKey == "")
        XCTAssert(bar.apiToken == "")
    }
    
    
    func test_equality_function() {
        
        var foo = SoracomCredentials.init(withDictionary: testValues)
        let bar = SoracomCredentials.init(withDictionary: testValues)
        let baz = SoracomCredentials.init(withDictionary: testValues)
        
        XCTAssert(foo == bar && bar == baz && baz == foo)
        
        foo.emailAddress = "something different"
        XCTAssert(foo != bar && bar == baz && baz != foo)
        
        foo.emailAddress = bar.emailAddress
        XCTAssert(foo == bar && bar == baz && baz == foo)
    }
    
    
    func test_namespaces() {
        // Mason 2016-04-13: doing the namespace feature test-first.
        
        let namespaceFromDefaultStr = NSUUID(UUIDString: "00000000-0000-0000-0000-DEFDEFDEFDEF")
        XCTAssertNotNil(namespaceFromDefaultStr)
        
        one.writeToSecurePersistentStorage()
        var read = SoracomCredentials(withStorageIdentifier: nil)
        XCTAssert(read == one)

        two.writeToSecurePersistentStorage()
        read = SoracomCredentials(withStorageIdentifier: nil)
        XCTAssert(read == two)
        
        let namespace1 = NSUUID()
        let namespace2 = NSUUID()
        
        one.writeToSecurePersistentStorage(namespace: namespace1)
        
        read = SoracomCredentials(withStorageIdentifier: nil)
        XCTAssert(read == two) // should still be two, because we wrote one with a different namespcce
        
        read = SoracomCredentials(withStorageIdentifier: nil, namespace: namespace1)
        XCTAssert(read == one)

        read = SoracomCredentials(withStorageIdentifier: nil, namespace: namespace2)
        XCTAssert(read != two) // should be blank instance; we haven't written yet
        two.writeToSecurePersistentStorage(namespace: namespace2)
        read = SoracomCredentials(withStorageIdentifier: nil, namespace: namespace2)
        XCTAssert(read == two)
        
        // Now for good measure, let's assert writing to namespace2 didn't fubar namespace1
        read = SoracomCredentials(withStorageIdentifier: nil, namespace: namespace1)
        XCTAssert(read == one)
    }
    
    
    func test_blank() {
        
        var c: SoracomCredentials
        c = SoracomCredentials(type: .RootAccount)
        XCTAssert(c.blank)
        c.emailAddress = "a"
        XCTAssert(!c.blank)
        c.emailAddress = ""
        XCTAssert(c.blank)
        c.apiToken = "hi, my name is"
        XCTAssert(!c.blank)
        c.apiToken = ""
        XCTAssert(c.blank)
    }
    
    
    func test_buildNamespacedIdentifier() {
        
    }

}
