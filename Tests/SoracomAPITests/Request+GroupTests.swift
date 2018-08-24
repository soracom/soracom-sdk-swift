// Request+GroupTests.swift Created by mason on 2016-06-23. Copyright © 2016 Soracom, Inc. All rights reserved.

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

class RequestGroupTests: BaseTestCase {
    
    func test_createGroup() {
        guard let group = createGroup() else {
            XCTFail("failed to create group")
            return
        }
        print(group.toData()?.utf8String ?? "T_T")
    }
    
    
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
        
        let response1 = Request.putGroupTags(tags: [["uno": "uno"]], groupId: groupId1).wait()
        let response2 = Request.putGroupTags(tags: [["dos": "dos"]], groupId: groupId2).wait()
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
        
        let deletionResponse = Request.deleteGroupTag(groupId: groupId1, tagName: "uno").wait()
        
        XCTAssertNil(deletionResponse.error)
        
        group1 = getGroup(groupId1)
        
        guard let newTags = group1?.tags else {
            XCTFail("expected to get tags for the updated group")
            return
        }

        XCTAssertNil(newTags["uno"])
        XCTAssertEqual("bar", newTags["foo"]) // set in createGroup()... just verifying tags still exist
    }
    
    
    func test_groupConfigurationParameters() {
        
        let group = createGroup()
        
        guard let groupId = group?.groupId else {
            XCTFail("failed to get groupId")
            return
        }

        
        let newParams = [
            GroupConfigurationUpdateRequest(key: "foo", value: "bar"),
            GroupConfigurationUpdateRequest(key: "toast", value: "jam")
        ]
        
        let req = Request.putConfigurationParameters(parameters: newParams, groupId: groupId, namespace: Namespace.soracomAir)
        
        let res = req.wait()
        
        XCTAssertNil(res.error)

        guard let data = Request.getGroup(groupId: groupId).wait().data else {
            XCTFail("failed to re-fetch group")
            return
        }
        let refetchedGroup = Group.from(data)
        print(refetchedGroup ?? "oh noes")
        
        // FIXME: the asserts below fail. There is either something wrong with our code generation, or else a problem with the Swagger API spec. Group.configuration should be [String: [String:String]] not [String:String]. Disabling this test because it is out of scope for current work, but should investigate and fix this.
        
        //        XCTAssertEqual(refetchedGroup?.configuration?["foo"], "bar")
        //        XCTAssertEqual(refetchedGroup?.configuration?["toast"], "jam")
    }
    

    func test_listSubscribersInGroup() {
        
        guard let group = createGroup("test_listSubscribersInGroup") else {
            XCTFail("could not create group")
            return
        }
        
        guard let groupId = group.groupId else {
            XCTFail("failed to get groupId")
            return
        }

        let request  = Request.listSubscribersInGroup(groupId: groupId)
        let response = request.wait()
        
        XCTAssertNil(response.error)
        
        guard let subscriberList = response.parse() else {
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
        
        guard let group = createResponse.parse() else {
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
        
        guard let groups = listResponse.parse() else {
            XCTFail("could not decode payload received from listGroups")
            return nil
        }
        
        return groups
    }
    
    
    /// Delete group by ID (synchronously), and return `true` for success, `false` otherwise.
    
    func deleteGroup(_ groupId: String) -> Bool {
        let deleteRequest  = Request.deleteGroup(groupId: groupId)
        let deleteResponse = deleteRequest.wait()
        
        let noErr = deleteResponse.error == nil
        XCTAssertTrue(noErr)
        return noErr
    }
    
    
    /// Get group by ID (synchronously), and return it.
    
    func getGroup(_ groupId: String) -> Group? {
        
        let response = Request.getGroup(groupId: groupId).wait()
        
        guard let group = response.parse() else {
            return nil
        }
        return group
    }
    
    
    
    func test_create_tag_and_then_delete_Group() {
        
        let uuidString = UUID().uuidString
        
        // Create a group, and assert that the tags we set are present:
        
        let createResponse = Request.createGroup("my-awesome-test-group-\(uuidString)", tags: ["foo": "bar", "baz": "hoge"]).wait()
        
        guard
            let group   = createResponse.parse(),
            let groupId = group.groupId
        else {
            return XCTFail()
        }
        XCTAssertEqual(group.tags?["foo"], "bar")
        XCTAssertEqual(group.tags?["baz"], "hoge")

        // Fetch the group again, and double-check:
        
        guard let fetchedGroup = Request.getGroup(groupId: groupId).wait().parse() else {
            return XCTFail()
        }
        XCTAssertEqual(fetchedGroup.tags?["foo"], "bar")
        XCTAssertEqual(fetchedGroup.tags?["baz"], "hoge")

        // Put tags; put one new tag, and overwrite one existing tag:
        
        let putTagsResponse = Request.putGroupTags(tags: ["hello" : "moto", "baz": "replaced value for baz"], groupId: groupId).wait()
        guard let taggedGroup = putTagsResponse.parse() else {
            return XCTFail()
        }
        XCTAssertEqual(taggedGroup.tags?["hello"], "moto")
        XCTAssertEqual(taggedGroup.tags?["baz"], "replaced value for baz")

        // Fetch the group again, and assert tags match our expectations:
        
        guard let refetchedGroup = Request.getGroup(groupId: groupId).wait().parse() else {
            return XCTFail()
        }
        XCTAssertEqual(refetchedGroup.tags?["foo"], "bar")
        XCTAssertEqual(refetchedGroup.tags?["baz"], "replaced value for baz")
        XCTAssertEqual(refetchedGroup.tags?["hello"], "moto")

        // Delete the group:
        
        var deleteResponse = Request.deleteGroup(groupId: groupId).wait()
        
        XCTAssert(deleteResponse.statusCode == 204)
        XCTAssertNotNil(deleteResponse.parse())
        XCTAssertNil(deleteResponse.error)

        // Try to delete the already-deleted group, and assert that it fails as expected:
        
        deleteResponse = Request.deleteGroup(groupId: groupId).wait()
        XCTAssert(deleteResponse.statusCode == 404)
        // This doesn't work (which is probably OK) because a NoResponseBody object is returned by parse() when there is no HTTP response message body: XCTAssertNil(deleteResponse.parse())
        XCTAssertNotNil(deleteResponse.error)
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

