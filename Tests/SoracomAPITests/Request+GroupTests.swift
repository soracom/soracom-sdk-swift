// Request+GroupTests.swift Created by mason on 2016-06-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import XCTest

@testable import SoracomAPI

class RequestGroupTests: BaseTestCase {
    
    func test_CRUD_groups() {
        
        guard let group = createGroup() else {
            XCTFail("failed to create group")
            return
        }
        
        guard let groups = listGroups() else {
            XCTFail("failed to list groups")
            return
        }
        
        guard let groupId = group.groupId else {
            XCTFail("failed to get groupId")
            return
        }
        let found   = groups.filter {$0.groupId == groupId}
        
        guard found.count > 0 else {
            XCTFail("did not get any groups matching expected groupId \(groupId)")
            return
        }
        
        XCTAssert(found.count == 1, "got more than 1 match for groupId")
        
        let foundGroup = found[0]

        guard let tags = foundGroup.tags else {
            XCTFail("no tags found")
            return
        }
        XCTAssert(tags["foo"] == "bar", "tags not right")
        
        guard deleteGroup(groupId) else {
            XCTFail("deleteGroup failed")
            return
        }

        guard let groupsAfterDelete = listGroups() else {
            XCTFail("failed to list groups the second time")
            return
        }
        
        let foundAfterDelete = groupsAfterDelete.filter {$0.groupId == groupId}
        XCTAssert(foundAfterDelete.count == 0, "got >0 matches for groupId that should have been deleted")
    }
    
    
    func test_putGroupTags() {
        
        var group1 = createGroup()
        var group2 = createGroup()
        
        guard let groupId1 = group1?.groupId, let groupId2 = group2?.groupId else {
            XCTFail("failed to create groups")
            return
        }
        
        let response1 = Request.putGroupTags(groupId1, tags: ["uno": "uno"]).wait()
        let response2 = Request.putGroupTags(groupId2, tags: ["dos": "dos"]).wait()
        
        XCTAssertNil(response1.error)
        XCTAssertNil(response2.error)
        
        group1 = getGroup(groupId1)
        group2 = getGroup(groupId2)
        
        guard let tags1 = group1?.tags, let tags2 = group2?.tags else {
            XCTFail("expected to get tags for both groups")
            return
        }
        
        XCTAssert(tags1["uno"] == "uno")
        XCTAssert(tags2["dos"] == "dos")
        
        let deletionResponse = Request.deleteGroupTag(groupId1, tagName: "uno").wait()
        
        XCTAssertNil(deletionResponse.error)
        
        group1 = getGroup(groupId1)
        
        guard let newTags = group1?.tags else {
            XCTFail("expected to get tags for the updated group")
            return
        }

        XCTAssertNil(newTags["uno"])
        XCTAssertEqual("bar", newTags["foo"]) // set in createGroup()... just verifying tags still exist
    }
    
    
//    func test_putConfigurationParameters_and_deleteConfigurationParameter() {
//
//        guard let group = createGroup() else {
//            XCTFail("could not create group")
//            return
//        }
//        
//        guard let groupId = group.groupId else {
//            XCTFail("failed to get groupId")
//            return
//        }
//        
//        let params = [
//            ConfigurationParameter(key: "foo", value: "bar"),
//            ConfigurationParameter(key: "toast", value: "jam"),
//        ]
//        
//        _ = Request.putConfigurationParameters(groupId, namespace: .SoracomAir, parameters: params).wait()
//        
//        let result = getGroup(groupId)
//        
//        print(result)
//        
//        
//        guard let config = (result?.configuration) else {
//            XCTFail("derp derp")
//            return
//        }
//        
//        
//        guard let airConfig = config[.SoracomAir.rawValue] else {
//            XCTFail("xxxx")
//            return
//        }
//
//        XCTAssertEqual("bar", airConfig["foo"])
//        XCTAssertEqual("jam", airConfig["toast"])
//        
//        let deletionResponse = Request.deleteConfigurationParameter(groupId, namespace: .SoracomAir, parameterName: "foo").wait()
//        
//        print(deletionResponse)
//        
//        XCTAssertNil(deletionResponse.error)
//        
//        let result2 = getGroup(groupId)
//
//        guard let airConfig2 = result2?.configuration?[.SoracomAir] else {
//            XCTFail("xxxx")
//            return
//        }
//        
//        XCTAssertNil(airConfig2["foo"])
//        XCTAssertEqual("jam", airConfig["toast"])
//    }
//    
    
    func test_listSubscribersInGroup() {
        
        guard let group = createGroup("test_listSubscribersInGroup") else {
            XCTFail("could not create group")
            return
        }
        
        guard let groupId = group.groupId else {
            XCTFail("failed to get groupId")
            return
        }

        let request  = Request.listSubscribersInGroup(groupId)
        let response = request.wait()
        
        XCTAssertNil(response.error)
        
        guard let subscriberList = Subscriber.listFrom(response.payload) else {
            XCTFail("did not get subscriber list")
            return
        }
        
        print(subscriberList)
        
        // FIXME: someday we should probably put >0 subscribers in the group and assert we got the right subscribers
    }

    
    // MARK: - Basic building block functions for these tests
    //
    // These functions may call XCTFail() if they see unexpected results.
    
    
    /// Create a Group instance (synchronously) with our standard test properties, do some sanity checks on the response from the API server, and return the group instance (or nil if any error occurred).
    
    func createGroup(_ name: String = "group 1") -> Group? {
        
        let createRequest  = Request.createGroup(name, tags: ["foo": "bar"])
        let createResponse = createRequest.wait()
        
        XCTAssertNil(createResponse.error)
        
        guard let payload = createResponse.payload else {
            XCTFail("expected payload")
            return nil
        }
        
        guard let group = Group.from(payload) else {
            XCTFail("expected group")
            return nil
        }
        
        guard let groupId = group.groupId else {
            XCTFail("failed to get groupId")
            return nil
        }
        
        XCTAssert(groupId.count > 0, "groupId is empty")
        
        guard let tags = group.tags else {
            XCTFail("no tags found")
            return nil
        }
        guard let createdTime = group.createdTime else {
            XCTFail("")
            return nil
        }
        
        XCTAssert(tags["foo"] == "bar", "tags not right")
        XCTAssert(createdTime > 0)
        
        return group
    }
    
    
    /// List all groups (synchronously) and return the list, or nil on failure.
    
    func listGroups() -> [Group]? {
        
        let listRequest  = Request.listGroups()
        let listResponse = listRequest.wait()
        
        XCTAssertNil(listResponse.error)
        
        guard let payload = listResponse.payload else {
            XCTFail("no payload received from listGroups")
            return nil
        }
        
        guard let groups = Group.listFrom(payload) else {
            XCTFail("could not decode payload received from listGroups")
            return nil
        }
        return groups
    }
    
    
    /// Delete group by ID (synchronously), and return `true` for success, `false` otherwise.
    
    func deleteGroup(_ groupId: String) -> Bool {
        let deleteRequest  = Request.deleteGroup(groupId)
        let deleteResponse = deleteRequest.wait()
        
        let noErr = deleteResponse.error == nil
        XCTAssertTrue(noErr)
        return noErr
    }
    
    
    /// Get group by ID (synchronously), and return it.
    
    func getGroup(_ groupId: String) -> Group? {
        
        let response = Request.getGroup(groupId).wait()
        
        guard let payload = response.payload else {
            return nil
        }
        return Group.from(payload)
    }

}

#if os(Linux)
    extension RequestGroupTests {
        static var allTests : [(String, (RequestGroupTests) -> () throws -> Void)] {
            return [
                ("test_CRUD_groups", test_CRUD_groups),
                ("test_putGroupTags", test_putGroupTags),
                ("test_listSubscribersInGroup", test_listSubscribersInGroup),
            ]
        }
    }
#endif
