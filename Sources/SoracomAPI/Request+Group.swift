// Request+Group.swift Created by Mason Mark on 2018-08-21.


extension Request where T == Group {
    
    /**
     Convenience method to create a new group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/createGroup)
     
     Note that the `name` parameter is just a convenience that adds a tag with key "name" and the value supplied. (Note that the `name` parameter will **replace** any existing value for the key "name" that exists in `tags`.)
     */
    public class func createGroup(_ name: String? = nil, tags: [String:String]? = nil, responseHandler: ResponseHandler<Group>? = nil) -> Request {
        
        let req    = Request<Group>.init("/groups", responseHandler: responseHandler)
        req.method = .post
        
        var tags = tags ?? [:]
        
        if let name = name {
            tags["name"] = name
        }
        
        return createGroup(tags: CreateGroupRequest(tags: tags), responseHandler: responseHandler)
    }
}

