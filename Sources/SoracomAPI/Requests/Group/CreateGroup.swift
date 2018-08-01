extension Request where T == Group {

    public class func createGroup(
        tags: CreateGroupRequest, 
        responseHandler: ResponseHandler<Group>? = nil
    ) ->   Request<Group> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createGroup(tags: tags,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createGroup()) is not sufficient):

        return req
    }
    
    /// Create a new group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/createGroup)
    ///
    /// Note that the `name` parameter is just a convenience that adds a tag with key "name" and the value supplied. (Note that the `name` parameter will **replace** any existing value for the key "name" that exists in `tags`.)
    
    public class func createGroup(_ name: String? = nil, tags: [String:String]? = nil, responseHandler: ResponseHandler<Group>? = nil) -> Request {
        
        let req    = Request<Group>.init("/groups", responseHandler: responseHandler)
        req.method = .post
        
        var tags = tags ?? [:]
        
        if let name = name {
            tags["name"] = name
        }
        
        req.messageBody = CreateGroupRequest(tags: tags).toData()
        
        req.expectedHTTPStatus = 201
        
        return req
    }

}
