//  KeychainTests.swift Created by mason on 2016-02-21. Copyright © 2016 masonmark.com. All rights reserved.

import XCTest

public class KeychainTests: XCTestCase {
    
    static var bundleId: String {
        return Bundle.main.bundleIdentifier ?? "missing-bundle-id"
    }
    
    let key1 = "\(KeychainTests.bundleId).foo.bar.baz.test.key.for.KeychainTests"
    let key2 = "\(KeychainTests.bundleId).the.freedom.of.birds.is.an.insult.to.me.KeychainTests"
    
    
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
    
}
