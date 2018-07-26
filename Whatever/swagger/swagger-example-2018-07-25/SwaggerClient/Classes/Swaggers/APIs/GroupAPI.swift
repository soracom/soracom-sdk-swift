//
// GroupAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class GroupAPI {
    /**
     Create Group.
     
     - parameter tags: (body) Tags for group to be created. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createGroup(tags: CreateGroupRequest, completion: @escaping ((_ data: Group?,_ error: Error?) -> Void)) {
        createGroupWithRequestBuilder(tags: tags).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Create Group.
     - POST /groups
     - Create a new group.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "lastModifiedTime" : 6,
  "configuration" : { },
  "groupId" : "groupId",
  "createdTime" : 0,
  "operatorId" : "operatorId",
  "tags" : {
    "location" : "tokyo"
  }
}}]
     
     - parameter tags: (body) Tags for group to be created. 

     - returns: RequestBuilder<Group> 
     */
    open class func createGroupWithRequestBuilder(tags: CreateGroupRequest) -> RequestBuilder<Group> {
        let path = "/groups"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: tags)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Group>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     * enum for parameter namespace
     */
    public enum Namespace_deleteConfigurationParameter: String { 
        case soracomAir = "SoracomAir"
        case soracomBeam = "SoracomBeam"
        case soracomEndorse = "SoracomEndorse"
        case soracomFunnel = "SoracomFunnel"
        case soracomHarvest = "SoracomHarvest"
        case soracomKrypton = "SoracomKrypton"
    }

    /**
     Delete Group Configuration Parameters.
     
     - parameter groupId: (path) Target group. 
     - parameter namespace: (path) Namespace of target parameters. 
     - parameter name: (path) Parameter name to be deleted. (This will be part of a URL path, so it needs to be percent-encoded. In JavaScript, specify the name after it has been encoded using encodeURIComponent().) 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteConfigurationParameter(groupId: String, namespace: Namespace_deleteConfigurationParameter, name: String, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteConfigurationParameterWithRequestBuilder(groupId: groupId, namespace: namespace, name: name).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Delete Group Configuration Parameters.
     - DELETE /groups/{group_id}/configuration/{namespace}/{name}
     - Delete parameters for the specified group.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter groupId: (path) Target group. 
     - parameter namespace: (path) Namespace of target parameters. 
     - parameter name: (path) Parameter name to be deleted. (This will be part of a URL path, so it needs to be percent-encoded. In JavaScript, specify the name after it has been encoded using encodeURIComponent().) 

     - returns: RequestBuilder<Void> 
     */
    open class func deleteConfigurationParameterWithRequestBuilder(groupId: String, namespace: Namespace_deleteConfigurationParameter, name: String) -> RequestBuilder<Void> {
        var path = "/groups/{group_id}/configuration/{namespace}/{name}"
        path = path.replacingOccurrences(of: "{group_id}", with: "\(groupId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{namespace}", with: "\(namespace.rawValue)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{name}", with: "\(name)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Delete Group.
     
     - parameter groupId: (path) Target group ID. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteGroup(groupId: String, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteGroupWithRequestBuilder(groupId: groupId).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Delete Group.
     - DELETE /groups/{group_id}
     - Deletes the specified group by group ID
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter groupId: (path) Target group ID. 

     - returns: RequestBuilder<Void> 
     */
    open class func deleteGroupWithRequestBuilder(groupId: String) -> RequestBuilder<Void> {
        var path = "/groups/{group_id}"
        path = path.replacingOccurrences(of: "{group_id}", with: "\(groupId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Delete Group Tag.
     
     - parameter groupId: (path) Target group ID. 
     - parameter tagName: (path) Tag name to be deleted. (This will be part of a URL path, so it needs to be percent-encoded. In JavaScript, specify the name after it has been encoded using encodeURIComponent().) 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteGroupTag(groupId: String, tagName: String, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteGroupTagWithRequestBuilder(groupId: groupId, tagName: tagName).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Delete Group Tag.
     - DELETE /groups/{group_id}/tags/{tag_name}
     - Deletes tag from the specified group.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter groupId: (path) Target group ID. 
     - parameter tagName: (path) Tag name to be deleted. (This will be part of a URL path, so it needs to be percent-encoded. In JavaScript, specify the name after it has been encoded using encodeURIComponent().) 

     - returns: RequestBuilder<Void> 
     */
    open class func deleteGroupTagWithRequestBuilder(groupId: String, tagName: String) -> RequestBuilder<Void> {
        var path = "/groups/{group_id}/tags/{tag_name}"
        path = path.replacingOccurrences(of: "{group_id}", with: "\(groupId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{tag_name}", with: "\(tagName)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Get Group.
     
     - parameter groupId: (path) Target group ID. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getGroup(groupId: String, completion: @escaping ((_ data: Group?,_ error: Error?) -> Void)) {
        getGroupWithRequestBuilder(groupId: groupId).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Get Group.
     - GET /groups/{group_id}
     - Returns the group specified by the group ID.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "lastModifiedTime" : 6,
  "configuration" : { },
  "groupId" : "groupId",
  "createdTime" : 0,
  "operatorId" : "operatorId",
  "tags" : {
    "location" : "tokyo"
  }
}}]
     
     - parameter groupId: (path) Target group ID. 

     - returns: RequestBuilder<Group> 
     */
    open class func getGroupWithRequestBuilder(groupId: String) -> RequestBuilder<Group> {
        var path = "/groups/{group_id}"
        path = path.replacingOccurrences(of: "{group_id}", with: "\(groupId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Group>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     * enum for parameter tagValueMatchMode
     */
    public enum TagValueMatchMode_listGroups: String { 
        case exact = "exact"
        case _prefix = "prefix"
    }

    /**
     List Groups.
     
     - parameter tagName: (query) Tag name of the group. Filters through all groups that exactly match the tag name. When tag_name is specified, tag_value is required. (optional)
     - parameter tagValue: (query) Tag value of the groups. (optional)
     - parameter tagValueMatchMode: (query) Tag match mode. (optional, default to exact)
     - parameter limit: (query) Maximum number of results per response page. (optional)
     - parameter lastEvaluatedKey: (query) The last Group ID retrieved on the current page. By specifying this parameter, you can continue to retrieve the list from the next group onward. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func listGroups(tagName: String? = nil, tagValue: String? = nil, tagValueMatchMode: TagValueMatchMode_listGroups? = nil, limit: Int? = nil, lastEvaluatedKey: String? = nil, completion: @escaping ((_ data: [Group]?,_ error: Error?) -> Void)) {
        listGroupsWithRequestBuilder(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, limit: limit, lastEvaluatedKey: lastEvaluatedKey).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     List Groups.
     - GET /groups
     - Returns a list of groups.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example=[ {
  "lastModifiedTime" : 6,
  "configuration" : { },
  "groupId" : "groupId",
  "createdTime" : 0,
  "operatorId" : "operatorId",
  "tags" : {
    "location" : "tokyo"
  }
}, {
  "lastModifiedTime" : 6,
  "configuration" : { },
  "groupId" : "groupId",
  "createdTime" : 0,
  "operatorId" : "operatorId",
  "tags" : {
    "location" : "tokyo"
  }
} ]}]
     
     - parameter tagName: (query) Tag name of the group. Filters through all groups that exactly match the tag name. When tag_name is specified, tag_value is required. (optional)
     - parameter tagValue: (query) Tag value of the groups. (optional)
     - parameter tagValueMatchMode: (query) Tag match mode. (optional, default to exact)
     - parameter limit: (query) Maximum number of results per response page. (optional)
     - parameter lastEvaluatedKey: (query) The last Group ID retrieved on the current page. By specifying this parameter, you can continue to retrieve the list from the next group onward. (optional)

     - returns: RequestBuilder<[Group]> 
     */
    open class func listGroupsWithRequestBuilder(tagName: String? = nil, tagValue: String? = nil, tagValueMatchMode: TagValueMatchMode_listGroups? = nil, limit: Int? = nil, lastEvaluatedKey: String? = nil) -> RequestBuilder<[Group]> {
        let path = "/groups"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "tag_name": tagName, 
            "tag_value": tagValue, 
            "tag_value_match_mode": tagValueMatchMode?.rawValue, 
            "limit": limit?.encodeToJSON(), 
            "last_evaluated_key": lastEvaluatedKey
        ])
        

        let requestBuilder: RequestBuilder<[Group]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     List Subscribers in a group.
     
     - parameter groupId: (path) Target group ID. 
     - parameter limit: (query) Maximum number of results per response page. (optional)
     - parameter lastEvaluatedKey: (query) The IMSI of the last subscriber retrieved on the current page. By specifying this parameter, you can continue to retrieve the list from the next subscriber onward. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func listSubscribersInGroup(groupId: String, limit: Int? = nil, lastEvaluatedKey: String? = nil, completion: @escaping ((_ data: Group?,_ error: Error?) -> Void)) {
        listSubscribersInGroupWithRequestBuilder(groupId: groupId, limit: limit, lastEvaluatedKey: lastEvaluatedKey).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     List Subscribers in a group.
     - GET /groups/{group_id}/subscribers
     - Returns a list of subscribers that belong to the specified group by group ID.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "lastModifiedTime" : 6,
  "configuration" : { },
  "groupId" : "groupId",
  "createdTime" : 0,
  "operatorId" : "operatorId",
  "tags" : {
    "location" : "tokyo"
  }
}}]
     
     - parameter groupId: (path) Target group ID. 
     - parameter limit: (query) Maximum number of results per response page. (optional)
     - parameter lastEvaluatedKey: (query) The IMSI of the last subscriber retrieved on the current page. By specifying this parameter, you can continue to retrieve the list from the next subscriber onward. (optional)

     - returns: RequestBuilder<Group> 
     */
    open class func listSubscribersInGroupWithRequestBuilder(groupId: String, limit: Int? = nil, lastEvaluatedKey: String? = nil) -> RequestBuilder<Group> {
        var path = "/groups/{group_id}/subscribers"
        path = path.replacingOccurrences(of: "{group_id}", with: "\(groupId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "limit": limit?.encodeToJSON(), 
            "last_evaluated_key": lastEvaluatedKey
        ])
        

        let requestBuilder: RequestBuilder<Group>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     * enum for parameter namespace
     */
    public enum Namespace_putConfigurationParameters: String { 
        case soracomAir = "SoracomAir"
        case soracomBeam = "SoracomBeam"
        case soracomEndorse = "SoracomEndorse"
        case soracomFunnel = "SoracomFunnel"
        case soracomHarvest = "SoracomHarvest"
        case soracomKrypton = "SoracomKrypton"
    }

    /**
     Update Group Configuration Parameters.
     
     - parameter groupId: (path) Target group. 
     - parameter namespace: (path) Target configuration. 
     - parameter parameters: (body) Array of values for target object to be updated. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func putConfigurationParameters(groupId: String, namespace: Namespace_putConfigurationParameters, parameters: [GroupConfigurationUpdateRequest], completion: @escaping ((_ data: Group?,_ error: Error?) -> Void)) {
        putConfigurationParametersWithRequestBuilder(groupId: groupId, namespace: namespace, parameters: parameters).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Update Group Configuration Parameters.
     - PUT /groups/{group_id}/configuration/{namespace}
     - Adds/updates parameters for the specified group.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "lastModifiedTime" : 6,
  "configuration" : { },
  "groupId" : "groupId",
  "createdTime" : 0,
  "operatorId" : "operatorId",
  "tags" : {
    "location" : "tokyo"
  }
}}]
     
     - parameter groupId: (path) Target group. 
     - parameter namespace: (path) Target configuration. 
     - parameter parameters: (body) Array of values for target object to be updated. 

     - returns: RequestBuilder<Group> 
     */
    open class func putConfigurationParametersWithRequestBuilder(groupId: String, namespace: Namespace_putConfigurationParameters, parameters: [GroupConfigurationUpdateRequest]) -> RequestBuilder<Group> {
        var path = "/groups/{group_id}/configuration/{namespace}"
        path = path.replacingOccurrences(of: "{group_id}", with: "\(groupId)", options: .literal, range: nil)
        path = path.replacingOccurrences(of: "{namespace}", with: "\(namespace.rawValue)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: parameters)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Group>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Update Group Tags.
     
     - parameter groupId: (path) Target group ID. 
     - parameter tags: (body) Array of values for tags to be updated. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func putGroupTags(groupId: String, tags: [TagUpdateRequest], completion: @escaping ((_ data: Subscriber?,_ error: Error?) -> Void)) {
        putGroupTagsWithRequestBuilder(groupId: groupId, tags: tags).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Update Group Tags.
     - PUT /groups/{group_id}/tags
     - Adds/updates tags of specified configuration group.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "expiryAction" : "expiryAction",
  "lastModifiedAt" : 1,
  "serialNumber" : "serialNumber",
  "moduleType" : "moduleType",
  "groupId" : "groupId",
  "ipAddress" : "ipAddress",
  "sessionStatus" : {
    "gatewayPublicIpAddress" : "gatewayPublicIpAddress",
    "lastUpdatedAt" : 5,
    "gatewayPrivateIpAddress" : "gatewayPrivateIpAddress",
    "imei" : "imei",
    "online" : true,
    "ueIpAddress" : "ueIpAddress",
    "vpgId" : "vpgId",
    "dnsServers" : [ "dnsServers", "dnsServers" ]
  },
  "imsi" : "imsi",
  "tags" : { },
  "speedClass" : "speedClass",
  "createdAt" : 0,
  "expiredAt" : 6,
  "iccid" : "iccid",
  "imeiLock" : {
    "imei" : "imei"
  },
  "terminationEnabled" : true,
  "msisdn" : "msisdn",
  "operatorId" : "operatorId",
  "plan" : 5,
  "apn" : "apn",
  "status" : "status"
}}]
     
     - parameter groupId: (path) Target group ID. 
     - parameter tags: (body) Array of values for tags to be updated. 

     - returns: RequestBuilder<Subscriber> 
     */
    open class func putGroupTagsWithRequestBuilder(groupId: String, tags: [TagUpdateRequest]) -> RequestBuilder<Subscriber> {
        var path = "/groups/{group_id}/tags"
        path = path.replacingOccurrences(of: "{group_id}", with: "\(groupId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: tags)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Subscriber>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}