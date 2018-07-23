// SoracomCredentialsTests.swift Created by mason on 2016-02-21. Copyright © 2016 Soracom, Inc. All rights reserved.

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

class SoracomCredentialsTests: BaseTestCase {
    
    /// Overridden to set the default credentials storage namespace to `storageNamespaceForJunkCredentials`, because these tests exercise the actual credentials read/write API.
    
    override func setUp() {
        super.setUp()
        SoracomCredentials.defaultStorageNamespace = Client.sharedInstance.storageNamespaceForJunkCredentials
    }
    
    
    override func tearDown() {
        SoracomCredentials.defaultStorageNamespace = Client.sharedInstance.storageNamespaceForJunkCredentials
    }
    
    
    var one = SoracomCredentials(type: .RootAccount, emailAddress: "one", operatorID: "one", username: "one", password: "one", authKeyID: "one", authKeySecret: "one", apiKey: "one", token: "one")
    
    var two = SoracomCredentials(type: .SAM, emailAddress: "two", operatorID: "two", username: "two", password: "two", authKeyID: "two", authKeySecret: "two", apiKey: "two", token: "two")
    
    var testValues = [
        "type"          : "type value",
        "emailAddress"  : "emailAddress value",
        "operatorID"    : "operatorID value",
        "username"      : "username value",
        "password"      : "password value",
        "authKeyID"     : "authKeyID value",
        "authKeySecret" : "authKeySecret value",
        "apiKey"        : "apiKey value",
        "token"         : "token value",
    ]
    
    func test_serialization_via_swift4_codable() {
        
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(one) else {
            XCTFail(); 
            return;
        }
        print(encoded.utf8String ?? "OOPS")
        
        let decoder = JSONDecoder()
        
        guard let decoded = try? decoder.decode(SoracomCredentials.self, from: encoded) else {
            XCTFail(); 
            return;
        }
        print(decoded)
        
        guard let reencoded = try? encoder.encode(decoded) else {
            XCTFail(); 
            return;
        }
        print(reencoded)
        
        let baz = SoracomCredentials(jsonData: reencoded)
        XCTAssert(baz.type == .RootAccount)
        XCTAssert(baz.emailAddress == "one")
        XCTAssert(baz.operatorID == "one")
        XCTAssert(baz.username == "one")
        XCTAssert(baz.password == "one")
        XCTAssert(baz.authKeyID == "one")
        XCTAssert(baz.authKeySecret == "one")
        XCTAssert(baz.apiKey == "one")
        XCTAssert(baz.token == "one")
    }

    
    
    func test_store_in_keychain_original() {
        
        _ = one.save()
        two = SoracomCredentials.defaultSavedCredentials()
        
        XCTAssert(two == one)
    }
    
    
    func test_save() {
        
        // Each of the 4 types of credentials has an associated default key under which is is persisted to the Keychain.
        
        let rootCredentials    = SoracomCredentials(type: .RootAccount, emailAddress: "root@root.root")
        let samCredentials     = SoracomCredentials(type: .SAM, emailAddress: "sam@sam.sam")
        let authKeyCredentials = SoracomCredentials(type: .AuthKey, emailAddress: "authkey@authkey.authkey")
        let tokenCredentials   = SoracomCredentials(type: .KeyAndToken, emailAddress: "token@token.token")
        
        let allCredentials     = [rootCredentials, samCredentials, authKeyCredentials, tokenCredentials]
        
        for c in allCredentials {
            let stored = c.save()
            XCTAssertTrue(stored)
            
            let defaultCredentials = SoracomCredentials.defaultSavedCredentials()
            XCTAssert(defaultCredentials == c)
        }
    }
    
    
    func test_delete() {
        _ = one.save("foo bar")
        XCTAssertNotNil( SoracomCredentials(withStorageIdentifier: "foo bar") )
        XCTAssertTrue( SoracomCredentials.delete(identifier: "foo bar") )
        XCTAssert( SoracomCredentials(withStorageIdentifier: "foo bar").blank ) // init always returns something
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
        XCTAssert(foo.token == "token value")
        
        let bar = SoracomCredentials.init(withDictionary: [:])
        XCTAssert(bar.type == .RootAccount)
        XCTAssert(bar.emailAddress == "")
        XCTAssert(bar.operatorID == "")
        XCTAssert(bar.username == "")
        XCTAssert(bar.password == "")
        XCTAssert(bar.authKeyID == "")
        XCTAssert(bar.authKeySecret == "")
        XCTAssert(bar.apiKey == "")
        XCTAssert(bar.token == "")
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
        
        let namespaceFromDefaultStr = UUID(uuidString: "00000000-0000-0000-0000-DEFDEFDEFDEF")
        XCTAssertNotNil(namespaceFromDefaultStr)
        
        _ = one.save()
        var read = SoracomCredentials.defaultSavedCredentials()
        XCTAssert(read == one)

        _ = two.save()
        read = SoracomCredentials.defaultSavedCredentials()
        XCTAssert(read == two)
        
        let namespace1 = UUID()
        let namespace2 = UUID()
        
        _ = one.save(namespace: namespace1)
        
        read = SoracomCredentials.defaultSavedCredentials()
        XCTAssert(read == two) // should still be two, because we wrote one with a different namespcce
        
        read = SoracomCredentials.defaultSavedCredentials(namespace: namespace1)
        XCTAssert(read == one)

        read = SoracomCredentials.defaultSavedCredentials(namespace: namespace2)
        XCTAssert(read != two) // should be blank instance; we haven't written yet
        _ = two.save(namespace: namespace2)
        read = SoracomCredentials(withStorageIdentifier: nil, namespace: namespace2) // equiv to above
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
        c.token = "hi, my name is"
        XCTAssert(!c.blank)
        c.token = ""
        XCTAssert(c.blank)
    }
    
    
    func test_buildNamespacedIdentifier() {
        
        let identifier = SoracomCredentials.buildNamespacedIdentifier("foobarbaz")
        
        XCTAssertEqual(identifier, "\(SoracomCredentials.defaultStorageNamespace.uuidString).foobarbaz")
        
        guard let uuid = UUID(uuidString: "A57DC53C-BC86-4306-AFE4-D9F6D663FC69") else {
            XCTFail("wtf")
            return
        }
        
        SoracomCredentials.defaultStorageNamespace = uuid

        let identifier2 = SoracomCredentials.buildNamespacedIdentifier("foobarbaz")

        XCTAssertEqual(identifier2, "A57DC53C-BC86-4306-AFE4-D9F6D663FC69.foobarbaz")
    }

}

#if os(Linux)
    extension SoracomCredentialsTests {
        static var allTests : [(String, (SoracomCredentialsTests) -> () throws -> Void)] {
            return [
                ("test_serialization_via_swift4_codable", test_serialization_via_swift4_codable),
                ("test_store_in_keychain_original", test_store_in_keychain_original),
                ("test_save", test_save),
                ("test_delete", test_delete),
                ("test_serialization_roundtrip", test_serialization_roundtrip),
                ("test_deserialization", test_deserialization),
                ("test_equality_function", test_equality_function),
                ("test_namespaces", test_namespaces),
                ("test_blank", test_blank),
                ("test_buildNamespacedIdentifier", test_buildNamespacedIdentifier),
            ]
        }
    }
#endif 

