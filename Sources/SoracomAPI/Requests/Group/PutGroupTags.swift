extension Request where T == Group {

    /// Adds/updates tags of specified configuration group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/putGroupTags)

    public class func putGroupTags(
        tags: [TagUpdateRequest], 
        groupId: String,
        responseHandler: ResponseHandler<Group>? = nil
    ) ->   Request<Group> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _putGroupTags(tags: tags, groupId: groupId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_putGroupTags()) is not sufficient):

        return req
    }
    
    
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
