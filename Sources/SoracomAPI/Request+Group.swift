// Request+Group.swift Created by mason on 2016-06-23. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


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

    
    /**
     Adds/updates tags of specified configuration group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/putGroupTags)
     */
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

extension Request where T == NoResponseBody {
    
    /// Delete parameters for the specified group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/deleteConfigurationParameter)
    ///
    /// Note that this method will handle percent-encoding the configuration parameter name, as mentioned in the API docs, so `parameterName` can just be the name of the parameter as-is.
    
    public class func deleteConfigurationParameterHMMFIXME(
        
        groupId: String,
        namespace: Namespace,
        name: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
        ) ->   Request<NoResponseBody> {
        
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? name;
        
        // Mason 2016-06-30: FIXME: We don't currently have a way to make a request fail with an error before it is run. I think we probably should, but it is beyond the scope of what I am currently working on. I want to think about it more. Subclass that overrides run(), wait() and any other future methods that execute the request? Or extend Request itself to have some kind pre-execute error property that run(), wait() etc respect? Or other? Deferring by marking FIXME here because we really don't want to be careless with parameters that control data getting deleted. For now, though, this kludge:
        
        // Call the auto-generated implmentation, created from the API spec:
        let req = deleteConfigurationParameter(groupId: groupId, namespace: namespace, name: encodedName,  responseHandler: responseHandler)
        
        
        return req
    }
}

/// OLD PRE CODEGEN STUFF BELOW: FIXME: REVIEW/RELOCATE/DELETE
//extension Request {

//    /// Returns a list of groups. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/listGroups)
//
//    public class func listGroups(_ tagName: String?           = nil,
//                                tagValue: String?             = nil,
//                       tagValueMatchMode: TagValueMatchMode?  = nil,
//                                   limit: Int?                = nil,
//                        lastEvaluatedKey: String?             = nil,
//                         responseHandler: ResponseHandler?    = nil
//    ) -> Request {
//
//        let query  = makeQueryDictionary(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, limit: limit, lastEvaluatedKey: lastEvaluatedKey)
//
//        let req    = self.init("/groups", responseHandler: responseHandler)
//        req.query  = query
//        req.method = .get
//        return req
//    }
//
    
    
    
//    /// Deletes the specified group by group ID
//    ///
//    /// [API docs](https://dev.soracom.io/en/docs/api/#!/Group/deleteGroup)
//
//    public class func deleteGroup(_ groupId: String, responseHandler: ResponseHandler? = nil) -> Request {
//
//        let req    = self.init("/groups/\(groupId)", responseHandler: responseHandler)
//        req.method = .delete
//        req.expectedHTTPStatus = 204
//
//        return req
//    }
    
    
//    /// Returns the group specified by the group ID. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/getGroup)
//
//    public class func getGroup(_ groupId: String, responseHandler: ResponseHandler? = nil) -> Request {
//
//        let req    = self.init("/groups/\(groupId)", responseHandler: responseHandler)
//        req.method = .get
//        req.expectedHTTPStatus = 200
//
//        return req
//    }
    
    
//    /// Returns a list of subscribers that belong to the specified group by group ID. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/listSubscribersInGroup)
//
//    public class func listSubscribersInGroup(_ groupId: String, responseHandler: ResponseHandler? = nil) -> Request {
//
//        // FIXME: tests needed and API doc is wrong? (about the response payload)
//
//        let req    = self.init("/groups/\(groupId)/subscribers", responseHandler: responseHandler)
//        req.method = .get
//        req.expectedHTTPStatus = 200
//
//        return req
//    }
    
//
//    /// Adds/updates parameters for the specified group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/putConfigurationParameters)
//
//    public class func putConfigurationParameters(_ groupId: String, namespace: ConfigurationParametersNamespace, parameters: [_GroupConfigurationUpdateRequest], responseHandler: ResponseHandler? = nil) -> Request {
//
//        let req    = self.init("/groups/\(groupId)/configuration/\(namespace.rawValue)", responseHandler: responseHandler)
//        req.method = .put
//        req.expectedHTTPStatus = 200
//
//        req.messageBody = parameters.toData()
//
//        return req
//    }
//
    
//    /// Delete parameters for the specified group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/deleteConfigurationParameter)
//    ///
//    /// Note that this method will handle percent-encoding the configuration parameter name, as mentioned in the API docs, so `parameterName` can just be the name of the parameter as-is.
//
//    public class func deleteConfigurationParameter(_ groupId: String, namespace: ConfigurationParametersNamespace, parameterName: String, responseHandler: ResponseHandler? = nil) -> Request {
//
//        let encodedName = parameterName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)
//
//        // Mason 2016-06-30: FIXME: We don't currently have a way to make a request fail with an error before it is run. I think we probably should, but it is beyond the scope of what I am currently working on. I want to think about it more. Subclass that overrides run(), wait() and any other future methods that execute the request? Or extend Request itself to have some kind pre-execute error property that run(), wait() etc respect? Or other? Deferring by marking FIXME here because we really don't want to be careless with parameters that control data getting deleted. For now, though, this kludge:
//
//        let urlSegment = encodedName ?? parameterName
//
//        let path       = "/groups/\(groupId)/configuration/\(namespace.rawValue)/\(urlSegment)"
//        let req        = self.init(path, responseHandler: responseHandler)
//        req.method     = .delete
//        req.expectedHTTPStatus = 204
//
//        return req
//    }

    
//    /// Adds/updates tags of specified configuration group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/putGroupTags)
//    
//    public class func putGroupTags(_ groupId: String, tags: [String:String], responseHandler: ResponseHandler? = nil) -> Request {
//        
//        let req    = self.init("/groups/\(groupId)/tags", responseHandler: responseHandler)
//        req.method = .put
//        req.expectedHTTPStatus = 200
//        
//        var tagList: [TagUpdateRequest] = []
//        
//        for (k,v) in tags {
//            let tagUpdateRequest = TagUpdateRequest(tagName: k, tagValue: v)
//            tagList.append(tagUpdateRequest)
//        }
//        
//        req.messageBody = tagList.toData()
//        
//        return req
//    }
//    
    
//    /// [API docs](https://dev.soracom.io/en/docs/api/#!/Group/deleteGroupTag)
//
//    public class func deleteGroupTag(_ groupId: String, tagName: String, responseHandler: ResponseHandler? = nil) -> Request {
//
//        let req    = self.init("/groups/\(groupId)/tags/\(tagName)", responseHandler: responseHandler)
//        req.method = .delete
//        req.expectedHTTPStatus = 204
//
//        return req
//    }

//}
