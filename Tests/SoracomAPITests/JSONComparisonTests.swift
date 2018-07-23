// JSONComparisonTests.swift Created by mason on 2017-07-30. Copyright © 2017 Soracom, Inc. All rights reserved. 

import XCTest

#if !SKIP_TESTABLE_IMPORT_FOR_TESTS
@testable import SoracomAPI
#endif

class JSONComparisonTests: XCTestCase {
    
    func test_isEquivalentJSON() {
        let yep  = JSONComparison.areEquivalent("{\"a\":[], \"b\": {}}", "{\"b\":    {}, \"a\":    []}")
        let nope = JSONComparison.areEquivalent("{\"a\":[]}", "{\"a\": {}}")
        XCTAssertTrue(yep)
        XCTAssertFalse(nope)
    }
    
    
    func test_isEquivalentJSON_some_more() {
        let left = "[  {    \"imsi\":\"448675309635677\",    \"msisdn\":\"867530959582\",    \"ipAddress\":\"10.176.129.76\",    \"operatorId\":\"OP0078675309\",    \"apn\":\"soracom.io\",    \"type\":\"s1.fast\",    \"groupId\":\"86753093-9671-471f-a5ea-478675309d77\",    \"createdAt\":1453878675309,    \"lastModifiedAt\":1499848675309,    \"expiredAt\":null,    \"expiryAction\":\"deleteSession\",    \"terminationEnabled\":false,    \"status\":\"active\",    \"tags\":{      \"name\":\"test-sim-001\"    },    \"sessionStatus\":{      \"lastUpdatedAt\":1499848675309,    \"imei\":\"867530953095309\",    \"location\":null,    \"ueIpAddress\":\"10.176.129.76\",    \"dnsServers\":[      \"100.127.0.53\",      \"100.127.1.53\"    ],    \"online\":true,    \"gatewayPublicIpAddress\":\"86.75.30.9\"    },    \"imeiLock\":null,    \"speedClass\":\"s1.fast\",    \"moduleType\":\"nano\",    \"plan\":1,    \"iccid\":\"8986758675309663304\",    \"serialNumber\":\"DN0503867530900\",    \"expiryTime\":null,    \"createdTime\":1453878675309,    \"lastModifiedTime\":1499848675309  },  {    \"foo\": {    \"hoge\": [8,6,7,5,3,0,9],    \"truck\": \"fump\"    },    \"why\": \"because\",    \"oneMinus2\": -1  }]"
        
        let right = "[{\"tags\":{\"name\":\"test-sim-001\"},\"msisdn\":\"867530959582\",\"ipAddress\":\"10.176.129.76\",\"apn\":\"soracom.io\",\"imsi\":\"448675309635677\",\"type\":\"s1.fast\",\"groupId\":\"86753093-9671-471f-a5ea-478675309d77\",\"createdAt\":1453878675309,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"expiryAction\":\"deleteSession\",\"operatorId\":\"OP0078675309\",\"terminationEnabled\":false,\"status\":\"active\",\"sessionStatus\":{\"location\":null,\"ueIpAddress\":\"10.176.129.76\",\"lastUpdatedAt\":1499848675309,\"imei\":\"867530953095309\",\"dnsServers\":[\"100.127.0.53\",\"100.127.1.53\"],\"online\":true,\"gatewayPublicIpAddress\":\"86.75.30.9\"},\"imeiLock\":null,\"speedClass\":\"s1.fast\",\"expiryTime\":null,\"createdTime\":1453878675309,\"expiryAction\":\"deleteSession\",\"moduleType\":\"nano\",\"plan\":1,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"iccid\":\"8986758675309663304\",\"serialNumber\":\"DN0503867530900\",\"lastModifiedTime\":1499848675309},{\"oneMinus2\":-1,\"why\":\"because\",\"foo\":{\"truck\":\"fump\",\"hoge\":[8,6,7,5,3,0,9]}}]"
        
        XCTAssertTrue(JSONComparison.areEquivalent(left, right))
        XCTAssertTrue(JSONComparison.areEquivalent(right, left))
        
        var wrong = "[{\"tags\":{\"name\":\"test-sim-001\"},\"msisdn\":\"867530959582\",\"ipAddress\":\"10.176.129.76\",\"apn\":\"soracom.io\",\"imsi\":\"448675309635677\",\"type\":\"s1.fast\",\"groupId\":\"86753093-9671-471f-a5ea-478675309d77\",\"createdAt\":1453878675309,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"expiryAction\":\"deleteSession\",\"operatorId\":\"OP0078675309\",\"terminationEnabled\":false,\"status\":\"active\",\"sessionStatus\":{\"location\":null,\"ueIpAddress\":\"10.176.129.76\",\"lastUpdatedAt\":1499848675309,\"imei\":\"867530953095309\",\"dnsServers\":[\"100.127.0.53\",\"100.127.1.53\"],\"online\":false,\"gatewayPublicIpAddress\":\"86.75.30.9\"},\"imeiLock\":null,\"speedClass\":\"s1.fast\",\"expiryTime\":null,\"createdTime\":1453878675309,\"expiryAction\":\"deleteSession\",\"moduleType\":\"nano\",\"plan\":1,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"iccid\":\"8986758675309663304\",\"serialNumber\":\"DN0503867530900\",\"lastModifiedTime\":1499848675309},{\"oneMinus2\":-1,\"why\":\"because\",\"foo\":{\"truck\":\"fump\",\"hoge\":[8,6,7,5,3,0,9]}}]" // online is false
        
        XCTAssertFalse(JSONComparison.areEquivalent(left, wrong))
        XCTAssertFalse(JSONComparison.areEquivalent(wrong, left))
        
        wrong = "[{\"tags\":{\"name\":\"here is waldo!\"},\"msisdn\":\"867530959582\",\"ipAddress\":\"10.176.129.76\",\"apn\":\"soracom.io\",\"imsi\":\"448675309635677\",\"type\":\"s1.fast\",\"groupId\":\"86753093-9671-471f-a5ea-478675309d77\",\"createdAt\":1453878675309,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"expiryAction\":\"deleteSession\",\"operatorId\":\"OP0078675309\",\"terminationEnabled\":false,\"status\":\"active\",\"sessionStatus\":{\"location\":null,\"ueIpAddress\":\"10.176.129.76\",\"lastUpdatedAt\":1499848675309,\"imei\":\"867530953095309\",\"dnsServers\":[\"100.127.0.53\",\"100.127.1.53\"],\"online\":true,\"gatewayPublicIpAddress\":\"86.75.30.9\"},\"imeiLock\":null,\"speedClass\":\"s1.fast\",\"expiryTime\":null,\"createdTime\":1453878675309,\"expiryAction\":\"deleteSession\",\"moduleType\":\"nano\",\"plan\":1,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"iccid\":\"8986758675309663304\",\"serialNumber\":\"DN0503867530900\",\"lastModifiedTime\":1499848675309},{\"oneMinus2\":-1,\"why\":\"because\",\"foo\":{\"truck\":\"fump\",\"hoge\":[8,6,7,5,3,0,9]}}]" // name tag is different
        
        XCTAssertFalse(JSONComparison.areEquivalent(left, wrong))
        
        wrong = "[{\"tags\":{\"name\":\"test-sim-001\"},\"msisdn\":\"867530959582\",\"ipAddress\":\"10.176.129.76\",\"apn\":\"soracom.io\",\"imsi\":\"448675309635677\",\"type\":\"s1.fast\",\"groupId\":\"86753093-9671-471f-a5ea-478675309d77\",\"createdAt\":1453878675309,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"expiryAction\":\"deleteSession\",\"operatorId\":\"OP0078675309\",\"terminationEnabled\":false,\"status\":\"active\",\"sessionStatus\":{\"location\":null,\"ueIpAddress\":\"10.176.129.76\",\"lastUpdatedAt\":1499848675309,\"imei\":\"867530953095309\",\"dnsServers\":[\"100.127.0.53\",\"100.127.1.53\"],\"online\":true,\"gatewayPublicIpAddress\":\"86.75.30.9\"},\"imeiLock\":null,\"speedClass\":\"s1.fast\",\"expiryTime\":null,\"createdTime\":1453878675309,\"expiryAction\":\"deleteSession\",\"moduleType\":\"nano\",\"plan\":1,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"iccid\":\"8986758675309663304\",\"serialNumber\":\"DN0503867530900\",\"lastModifiedTime\":1499848675309},{\"oneMinus2\":-1,\"why\":\"because\",\"foo\":{\"truck\":\"fump\",\"hoge\":[8,6,7,5,3,0,9,10]}}]" // hoge has a secret
        
        XCTAssertFalse(JSONComparison.areEquivalent(left, wrong))
        
        wrong = "[{\"tags\":{\"name\":\"test-sim-001\"},\"msisdn\":\"867530959582\",\"ipAddress\":\"10.176.129.76\",\"apn\":\"soracom.io\",\"imsi\":\"448675309635677\",\"type\":\"s1.fast\",\"groupId\":\"86753093-9671-471f-a5ea-478675309d77\",\"createdAt\":1453878675309,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"expiryAction\":\"deleteSession\",\"operatorId\":\"OP0078675309\",\"terminationEnabled\":false,\"status\":\"active\",\"sessionStatus\":{\"location\":null,\"ueIpAddress\":\"10.176.129.76\",\"lastUpdatedAt\":1499848675309,\"imei\":\"867530953095309\",\"dnsServers\":[\"100.127.0.53\",\"100.127.1.waldo\"],\"online\":true,\"gatewayPublicIpAddress\":\"86.75.30.9\"},\"imeiLock\":null,\"speedClass\":\"s1.fast\",\"expiryTime\":null,\"createdTime\":1453878675309,\"expiryAction\":\"deleteSession\",\"moduleType\":\"nano\",\"plan\":1,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"iccid\":\"8986758675309663304\",\"serialNumber\":\"DN0503867530900\",\"lastModifiedTime\":1499848675309},{\"oneMinus2\":-1,\"why\":\"because\",\"foo\":{\"truck\":\"fump\",\"hoge\":[8,6,7,5,3,0,9]}}]" // second dns server
        
        XCTAssertFalse(JSONComparison.areEquivalent(left, wrong))
        
        wrong = "[{\"tags\":{\"name\":\"test-sim-001\"},\"msisdn\":\"867530959582\",\"ipAddress\":\"10.176.129.76\",\"apn\":\"soracom.io\",\"imsi\":\"448675309635677\",\"type\":\"s1.fast\",\"groupId\":\"86753093-9671-471f-a5ea-478675309d77\",\"createdAt\":1453878675309,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"expiryAction\":\"deleteSession\",\"operatorId\":\"OP0078675309\",\"terminationEnabled\":false,\"status\":\"active\",\"sessionStatus\":{\"location\":null,\"ueIpAddress\":\"10.176.129.76\",\"lastUpdatedAt\":1499848675309,\"imei\":\"867530953095309\",\"dnsServers\":[\"100.127.0.53\",\"100.127.1.53\"],\"online\":true,\"gatewayPublicIpAddress\":\"86.75.30.9\"},\"imeiLock\":null,\"speedClass\":\"s1.fast\",\"expiryTime\":null,\"createdTime\":1453878675309,\"expiryAction\":\"deleteSession\",\"moduleType\":\"nano\",\"plan\":1,\"lastModifiedAt\":1499848675309,\"expiredAt\":null,\"iccid\":\"8986758675309663304\",\"serialNumber\":\"DN0503867530900\",\"lastModifiedTime\":1499848675309},{\"oneMinus2\":-1,\"why\":\"because\",\"foo\":{\"truck\":\"fump\",\"hoge\":[8,6,7,5,3,0,9]}}, {\"waldo\":\"is here!\"}]" // extra waldo
        XCTAssertFalse(JSONComparison.areEquivalent(left, wrong))
        XCTAssertFalse(JSONComparison.areEquivalent(wrong, left))
    }
}


#if os(Linux)

    extension JSONComparisonTests {
        
        static var allTests : [(String, (JSONComparisonTests) -> () throws -> Void)] {
            return [
                ("test_isEquivalentJSON", test_isEquivalentJSON),
                ("test_isEquivalentJSON_some_more", test_isEquivalentJSON_some_more)
            ]
        }
    }
#endif
