//  KeychainTests.swift Created by mason on 2016-02-21. Copyright © 2016 Soracom, Inc.. All rights reserved.

import XCTest

#if USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomAPI
#else
    @testable import SoracomAPI
#endif

open class KeychainTests: BaseTestCase {

        
    let key1 = "foo.bar.baz.test.key.for.KeychainTests"
    let key2 = "the.freedom.of.birds.is.an.insult.to.me.KeychainTests"
    
    
    func test_basic() {
        let data1 = UUID().uuidString.data(using: String.Encoding.utf8)!
        let data2 = UUID().uuidString.data(using: String.Encoding.utf8)!
        XCTAssertNotEqual(data1, data2) // just a sanity check, of course this is always true
        
        var wroteOK = Keychain.write(key1, data: data1)
        XCTAssertTrue(wroteOK)
        XCTAssertEqual(Keychain.read(key1), data1)
        
        wroteOK = Keychain.write(key2, data: data2)
        XCTAssertTrue(wroteOK)
        XCTAssertEqual(Keychain.read(key2), data2)
        
        XCTAssertNil(Keychain.read(UUID().uuidString))
        
        XCTAssertTrue( Keychain.delete(key1) )
        XCTAssertNil( Keychain.read(key1) )
        
        XCTAssertNotNil( Keychain.read(key2) )
        XCTAssertTrue( Keychain.delete(key2) )
        XCTAssertNil( Keychain.read(key1) )
        
        XCTAssertFalse( Keychain.delete(key1) )
        XCTAssertFalse( Keychain.delete(key2) )
    }
    
    
    func test_empty_string_lookup() {
        // Mason 2016-02-21: This was a real bug; initial version of Keychain did return some data in this case.
        XCTAssertNil(Keychain.read(""))
    }
    
    
    func test_write_empty_data() {
        // Can't think of any reason to do this in real life, but I wrote this test just to make sure it didn't crash or anything.
        // Mason 2016-04-10: Well, one reason might be that you haven't implemented a delete method, bro... :-P
        
        _ = Keychain.write(key1, data: Data())
        let readData = Keychain.read(key1)
        XCTAssertEqual(readData, Data())
    }
    
    
    func test_readString_and_writeString() {
        let string1 = "foo bar baz", string2 = "The Humpty Dance is your chance to... what?"
        
        XCTAssert( Keychain.writeString(key1, string: string1) )
        XCTAssert( Keychain.readString(key1) == string1 )
        XCTAssert( Keychain.writeString(key1, string: string2) )
        XCTAssert( Keychain.readString(key1) == string2 )
    }
    
    
    func test_replace_logger() {
        var output = ""
        Keychain.errorLogger = { (_ errCode: OSStatus, _ whenTryingTo: String ) in
            output += String(errCode) + whenTryingTo
        }
        Keychain.errorLogger(1, "foo")
        Keychain.errorLogger(2, "hoge")
        XCTAssertEqual(output, "1foo2hoge")
    }
    
    
    func test_storage_identifier() {
        
        let originalValue = Keychain._storageIdentifier;
        Keychain._storageIdentifier = nil
        
        let isBundleId = Keychain.storageIdentifier == Bundle.main.bundleIdentifier
        let isDefault  = Keychain.storageIdentifier == "missing-storage-identifier"
        XCTAssert(isBundleId || isDefault)
        
        Keychain.storageIdentifier = "hoge"
        XCTAssert(Keychain.storageIdentifier == "hoge")
        
        Keychain._storageIdentifier = originalValue
    }
    
}


open class KeychainInsecureModeTests: KeychainTests {
    
    // Inherits all the same test methods as KeychainTests, but enables insecure mode before each
    
    open override func setUp() {
        super.setUp()
        Keychain.useInsecurePlaintextStorageAlways = true
    }
    
    
    open override func tearDown() {
        Keychain.useInsecurePlaintextStorageAlways = false;
        super.tearDown()
    }
    
}


#if os(Linux)
    extension KeychainTests {
        static var allTests : [(String, (KeychainTests) -> () throws -> Void)] {
            return [
                ("test_basic", test_basic),
                ("test_empty_string_lookup", test_empty_string_lookup),
                ("test_write_empty_data", test_write_empty_data),
                ("test_readString_and_writeString", test_readString_and_writeString),
                ("test_replace_logger", test_replace_logger),
                ("test_storage_identifier", test_storage_identifier),
            ]
        }
    }
#endif 


