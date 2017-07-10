// LinuxMain.swift Created by mason on 2017-07-10. Copyright © 2017 Soracom, Inc. All rights reserved.
#if os(Linux)
    
    import XCTest
    @testable import SoracomSDKSWiftTests
    
XCTMain([
    BaseTestCase.allTests
    ])
    
#endif

