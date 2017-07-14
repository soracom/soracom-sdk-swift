// LinuxMain.swift Created by mason on 2017-07-10. Copyright © 2017 Soracom, Inc. All rights reserved.
#if os(Linux)
    
    import XCTest
    @testable import SoracomSDKSwiftTests
    
    XCTMain([
        testCase(APIErrorTests.allTests),
        testCase(APIOperationTests.allTests),
        testCase(APIStructuresTests.allTests),
        testCase(BaseTestCaseTests.allTests),
        testCase(KeychainTests.allTests),
        testCase(PayloadTests.allTests),
        testCase(SoracomCredentialsTests.allTests),
    ])
    
#endif

