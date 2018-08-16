extension Request where T == Group {

    /// Adds/updates tags of specified configuration group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/putGroupTags)
    
    public class func putGroupTags(_ groupId: String, tags: [String:String], responseHandler: ResponseHandler<Group>? = nil) -> Request<Group> {
        
        let req    = self.init("/groups/\(groupId)/tags", responseHandler: responseHandler)
        req.method = .put
        req.expectedHTTPStatus = 200
        
        var tagList: [TagUpdateRequest] = []
        
        for (k,v) in tags {
            let tagUpdateRequest = TagUpdateRequest(tagName: k, tagValue: v)
            tagList.append(tagUpdateRequest)
        }
        
        return putGroupTags(tags: tagList, groupId: groupId, responseHandler: responseHandler)
    }
    

}
