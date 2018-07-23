// LinuxMain.swift Created by mason on 2017-07-10. Copyright © 2017 Soracom, Inc. All rights reserved.

#if os(Linux)
    
    import XCTest

    @testable import SoracomAPITests
    
    XCTMain([
        testCase(APIErrorTests.allTests),
        testCase(APIOperationTests.allTests),
        testCase(APIStructuresTests.allTests),
        testCase(BaseTestCaseTests.allTests),
        testCase(BeamStatsTests.allTests),
        testCase(CredentialTests.allTests),
        testCase(DevelopmentEnvironmentTests.allTests),
        testCase(IssueDebuggingTests.allTests),
        testCase(JSONComparisonTests.allTests),
        testCase(KeychainTests.allTests),
        testCase(KeyedEncodingContainerPayloadTests.allTests),
        testCase(NSDateSoracomAPITests.allTests),
        testCase(PayloadTests.allTests),
        testCase(RegisterSIMTests.allTests),
        testCase(RequestAuthTests.allTests),
        testCase(RequestCredentialsTests.allTests),
        testCase(RequestGroupTests.allTests),
        testCase(RequestSandboxTests.allTests),
        testCase(RequestSubscriberTests.allTests),
        testCase(RequestTests.allTests),
        testCase(ResponsePayloadTests.allTests),
        testCase(ResponseTests.allTests),
        testCase(SerializationTests.allTests),
        testCase(SubscriberTests.allTests),
        testCase(SoracomCredentialsTests.allTests),
    ])
    
#endif