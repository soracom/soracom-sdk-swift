//
// VirtualPrivateGatewayAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire



public class VirtualPrivateGatewayAPI: APIBase {
    
    
    
    /**
     
     Close SORACOM Gate.
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func closeGate(vpgId vpgId: String, completion: ((error: ErrorType?) -> Void)) {
        closeGateWithRequestBuilder(vpgId: vpgId).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Close SORACOM Gate.
     
     - POST /virtual_private_gateways/{vpgId}/gate/close
     - Close SORACOM Gate on the specified VPG.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter vpgId: (path) Target VPG ID. 

     - returns: RequestBuilder<Void> 
     */
    public class func closeGateWithRequestBuilder(vpgId vpgId: String) -> RequestBuilder<Void> {
        var path = "/virtual_private_gateways/{vpgId}/gate/close"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    /**
     
     Create Virtual Private Gateway.
     
     - parameter createVirtualPrivateGatewayRequest: (body) Request containing information for the new VPG to be created. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func createVirtualPrivateGateway(createVirtualPrivateGatewayRequest createVirtualPrivateGatewayRequest: CreateVirtualPrivateGatewayRequest, completion: ((data: VirtualPrivateGateway?, error: ErrorType?) -> Void)) {
        createVirtualPrivateGatewayWithRequestBuilder(createVirtualPrivateGatewayRequest: createVirtualPrivateGatewayRequest).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Create Virtual Private Gateway.
     
     - POST /virtual_private_gateways
     - Create new VPG.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "lastModifiedTime" : 123456789,
  "useInternetGateway" : true,
  "primaryServiceName" : "aeiou",
  "virtualInterfaces" : "",
  "createdTime" : 123456789,
  "id" : "aeiou",
  "type" : "",
  "vpcPeeringConnections" : { },
  "operatorId" : "aeiou",
  "status" : "aeiou",
  "tags" : { }
}}]
     
     - parameter createVirtualPrivateGatewayRequest: (body) Request containing information for the new VPG to be created. 

     - returns: RequestBuilder<VirtualPrivateGateway> 
     */
    public class func createVirtualPrivateGatewayWithRequestBuilder(createVirtualPrivateGatewayRequest createVirtualPrivateGatewayRequest: CreateVirtualPrivateGatewayRequest) -> RequestBuilder<VirtualPrivateGateway> {
        let path = "/virtual_private_gateways"
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = createVirtualPrivateGatewayRequest.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<VirtualPrivateGateway>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Create VPC Peering Connection
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter vpcPeeringConnection: (body) VPC peering connection to be created. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func createVpcPeeringConnection(vpgId vpgId: String, vpcPeeringConnection: CreateVpcPeeringConnectionRequest, completion: ((data: CreateVpcPeeringConnectionRequest?, error: ErrorType?) -> Void)) {
        createVpcPeeringConnectionWithRequestBuilder(vpgId: vpgId, vpcPeeringConnection: vpcPeeringConnection).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Create VPC Peering Connection
     
     - POST /virtual_private_gateways/{vpgId}/vpc_peering_connections
     - Creates a VPC peering connection for the specified VPG.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "destinationCidrBlock" : "aeiou",
  "peerOwnerId" : "aeiou",
  "peerVpcId" : "aeiou"
}}]
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter vpcPeeringConnection: (body) VPC peering connection to be created. 

     - returns: RequestBuilder<CreateVpcPeeringConnectionRequest> 
     */
    public class func createVpcPeeringConnectionWithRequestBuilder(vpgId vpgId: String, vpcPeeringConnection: CreateVpcPeeringConnectionRequest) -> RequestBuilder<CreateVpcPeeringConnectionRequest> {
        var path = "/virtual_private_gateways/{vpgId}/vpc_peering_connections"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = vpcPeeringConnection.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<CreateVpcPeeringConnectionRequest>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Delete VPG IP address map entry
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter key: (path) Target key to remove. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func deleteVirtualPrivateGatewayIpAddressMapEntry(vpgId vpgId: String, key: String, completion: ((data: IpAddressMapEntry?, error: ErrorType?) -> Void)) {
        deleteVirtualPrivateGatewayIpAddressMapEntryWithRequestBuilder(vpgId: vpgId, key: key).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Delete VPG IP address map entry
     
     - DELETE /virtual_private_gateways/{vpgId}/ip_address_map/{key}
     - Deletes an entry in VPG IP address map.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{output=none}]
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter key: (path) Target key to remove. 

     - returns: RequestBuilder<IpAddressMapEntry> 
     */
    public class func deleteVirtualPrivateGatewayIpAddressMapEntryWithRequestBuilder(vpgId vpgId: String, key: String) -> RequestBuilder<IpAddressMapEntry> {
        var path = "/virtual_private_gateways/{vpgId}/ip_address_map/{key}"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{key}", withString: "\(key)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<IpAddressMapEntry>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Delete VPC Peering Connection.
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter pcxId: (path) VPC peering connection ID to be deleted. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func deleteVpcPeeringConnection(vpgId vpgId: String, pcxId: String, completion: ((error: ErrorType?) -> Void)) {
        deleteVpcPeeringConnectionWithRequestBuilder(vpgId: vpgId, pcxId: pcxId).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Delete VPC Peering Connection.
     
     - DELETE /virtual_private_gateways/{vpgId}/vpc_peering_connections/{pcxId}
     - Deletes the specified VPC peering connection.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter pcxId: (path) VPC peering connection ID to be deleted. 

     - returns: RequestBuilder<Void> 
     */
    public class func deleteVpcPeeringConnectionWithRequestBuilder(vpgId vpgId: String, pcxId: String) -> RequestBuilder<Void> {
        var path = "/virtual_private_gateways/{vpgId}/vpc_peering_connections/{pcxId}"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{pcxId}", withString: "\(pcxId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    /**
     
     Get Virtual Private Gateway.
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func getVirtualPrivateGateway(vpgId vpgId: String, completion: ((error: ErrorType?) -> Void)) {
        getVirtualPrivateGatewayWithRequestBuilder(vpgId: vpgId).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Get Virtual Private Gateway.
     
     - GET /virtual_private_gateways/{vpgId}
     - Retrieves information about the specified VPG.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter vpgId: (path) Target VPG ID. 

     - returns: RequestBuilder<Void> 
     */
    public class func getVirtualPrivateGatewayWithRequestBuilder(vpgId vpgId: String) -> RequestBuilder<Void> {
        var path = "/virtual_private_gateways/{vpgId}"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    /**
     
     List VPG Gate peers
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func listGatePeers(vpgId vpgId: String, completion: ((data: [GatePeer]?, error: ErrorType?) -> Void)) {
        listGatePeersWithRequestBuilder(vpgId: vpgId).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     List VPG Gate peers
     
     - GET /virtual_private_gateways/{vpgId}/gate/peers
     - List Gate peers registered in the Virtual Private Gateway
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example=[ {
  "ownedByCustomer" : true,
  "outerIpAddress" : "aeiou",
  "innerIpAddress" : "aeiou"
} ]}]
     
     - parameter vpgId: (path) Target VPG ID. 

     - returns: RequestBuilder<[GatePeer]> 
     */
    public class func listGatePeersWithRequestBuilder(vpgId vpgId: String) -> RequestBuilder<[GatePeer]> {
        var path = "/virtual_private_gateways/{vpgId}/gate/peers"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[GatePeer]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    /**
     
     List VPG IP address map entries
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func listVirtualPrivateGatewayIpAddressMapEntries(vpgId vpgId: String, completion: ((data: [IpAddressMapEntry]?, error: ErrorType?) -> Void)) {
        listVirtualPrivateGatewayIpAddressMapEntriesWithRequestBuilder(vpgId: vpgId).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     List VPG IP address map entries
     
     - GET /virtual_private_gateways/{vpgId}/ip_address_map
     - Describes the list of IP addresse map entries in the Virtual Private Gateway
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example=[ {
  "ipAddress" : "aeiou",
  "type" : "aeiou",
  "key" : "aeiou"
} ]}]
     
     - parameter vpgId: (path) Target VPG ID. 

     - returns: RequestBuilder<[IpAddressMapEntry]> 
     */
    public class func listVirtualPrivateGatewayIpAddressMapEntriesWithRequestBuilder(vpgId vpgId: String) -> RequestBuilder<[IpAddressMapEntry]> {
        var path = "/virtual_private_gateways/{vpgId}/ip_address_map"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[IpAddressMapEntry]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    
    
    /**
     * enum for parameter tagValueMatchMode
     */
    public enum TagValueMatchMode_listVirtualPrivateGateways: String { 
        case Exact = "exact"
        case Prefix = "prefix"
    }

    
    
    
    
    
    
    
    /**
     
     List Virtual Private Gateways.
     
     - parameter tagName: (query) Tag name of the VPG. Filters through all VPGs that exactly match the tag name. When tag_name is specified, tag_value is required. (optional)
     - parameter tagValue: (query) Tag value of the VPGs. (optional)
     - parameter tagValueMatchMode: (query) Tag match mode. (optional, default to exact)
     - parameter limit: (query) Maximum number of results per response page. (optional)
     - parameter lastEvaluatedKey: (query) The last group ID retrieved on the current page. By specifying this parameter, you can continue to retrieve the list from the next VPG onward. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func listVirtualPrivateGateways(tagName tagName: String? = nil, tagValue: String? = nil, tagValueMatchMode: TagValueMatchMode_listVirtualPrivateGateways? = nil, limit: Int? = nil, lastEvaluatedKey: String? = nil, completion: ((data: [VirtualPrivateGateway]?, error: ErrorType?) -> Void)) {
        listVirtualPrivateGatewaysWithRequestBuilder(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, limit: limit, lastEvaluatedKey: lastEvaluatedKey).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     List Virtual Private Gateways.
     
     - GET /virtual_private_gateways
     - Returns a list of VPGs.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example=[ {
  "lastModifiedTime" : 123456789,
  "useInternetGateway" : true,
  "primaryServiceName" : "aeiou",
  "virtualInterfaces" : "",
  "createdTime" : 123456789,
  "id" : "aeiou",
  "type" : "",
  "vpcPeeringConnections" : { },
  "operatorId" : "aeiou",
  "status" : "aeiou",
  "tags" : { }
} ]}]
     
     - parameter tagName: (query) Tag name of the VPG. Filters through all VPGs that exactly match the tag name. When tag_name is specified, tag_value is required. (optional)
     - parameter tagValue: (query) Tag value of the VPGs. (optional)
     - parameter tagValueMatchMode: (query) Tag match mode. (optional, default to exact)
     - parameter limit: (query) Maximum number of results per response page. (optional)
     - parameter lastEvaluatedKey: (query) The last group ID retrieved on the current page. By specifying this parameter, you can continue to retrieve the list from the next VPG onward. (optional)

     - returns: RequestBuilder<[VirtualPrivateGateway]> 
     */
    public class func listVirtualPrivateGatewaysWithRequestBuilder(tagName tagName: String? = nil, tagValue: String? = nil, tagValueMatchMode: TagValueMatchMode_listVirtualPrivateGateways? = nil, limit: Int? = nil, lastEvaluatedKey: String? = nil) -> RequestBuilder<[VirtualPrivateGateway]> {
        let path = "/virtual_private_gateways"
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [
            "tag_name": tagName,
            "tag_value": tagValue,
            "tag_value_match_mode": tagValueMatchMode?.rawValue,
            "limit": limit,
            "last_evaluated_key": lastEvaluatedKey
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[VirtualPrivateGateway]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    
    
    
    /**
     
     Open SORACOM Gate.
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func openGate(vpgId vpgId: String, completion: ((error: ErrorType?) -> Void)) {
        openGateWithRequestBuilder(vpgId: vpgId).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Open SORACOM Gate.
     
     - POST /virtual_private_gateways/{vpgId}/gate/open
     - Open SORACOM Gate on the specified VPG.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter vpgId: (path) Target VPG ID. 

     - returns: RequestBuilder<Void> 
     */
    public class func openGateWithRequestBuilder(vpgId vpgId: String) -> RequestBuilder<Void> {
        var path = "/virtual_private_gateways/{vpgId}/gate/open"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Put an entry in VPG IP address map
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter putIpAddressMapEntryRequest: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func putVirtualPrivateGatewayIpAddressMapEntry(vpgId vpgId: String, putIpAddressMapEntryRequest: PutIpAddressMapEntryRequest, completion: ((data: IpAddressMapEntry?, error: ErrorType?) -> Void)) {
        putVirtualPrivateGatewayIpAddressMapEntryWithRequestBuilder(vpgId: vpgId, putIpAddressMapEntryRequest: putIpAddressMapEntryRequest).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Put an entry in VPG IP address map
     
     - POST /virtual_private_gateways/{vpgId}/ip_address_map
     - Puts an entry in VPG IP address map.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "ipAddress" : "aeiou",
  "type" : "aeiou",
  "key" : "aeiou"
}}]
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter putIpAddressMapEntryRequest: (body)  

     - returns: RequestBuilder<IpAddressMapEntry> 
     */
    public class func putVirtualPrivateGatewayIpAddressMapEntryWithRequestBuilder(vpgId vpgId: String, putIpAddressMapEntryRequest: PutIpAddressMapEntryRequest) -> RequestBuilder<IpAddressMapEntry> {
        var path = "/virtual_private_gateways/{vpgId}/ip_address_map"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = putIpAddressMapEntryRequest.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<IpAddressMapEntry>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Register VPG Gate peer
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter gatePeer: (body)  
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func registerGatePeer(vpgId vpgId: String, gatePeer: RegisterGatePeerRequest, completion: ((data: GatePeer?, error: ErrorType?) -> Void)) {
        registerGatePeerWithRequestBuilder(vpgId: vpgId, gatePeer: gatePeer).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Register VPG Gate peer
     
     - POST /virtual_private_gateways/{vpgId}/gate/peers
     - Register a host as a gate peer in the Virtual Private Gateway
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "ownedByCustomer" : true,
  "outerIpAddress" : "aeiou",
  "innerIpAddress" : "aeiou"
}}]
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter gatePeer: (body)  

     - returns: RequestBuilder<GatePeer> 
     */
    public class func registerGatePeerWithRequestBuilder(vpgId vpgId: String, gatePeer: RegisterGatePeerRequest) -> RequestBuilder<GatePeer> {
        var path = "/virtual_private_gateways/{vpgId}/gate/peers"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = gatePeer.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<GatePeer>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    /**
     
     Terminate Virtual Private Gateway.
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func terminateVirtualPrivateGateway(vpgId vpgId: String, completion: ((error: ErrorType?) -> Void)) {
        terminateVirtualPrivateGatewayWithRequestBuilder(vpgId: vpgId).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Terminate Virtual Private Gateway.
     
     - POST /virtual_private_gateways/{vpgId}/terminate
     - Terminates the specified VPG.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter vpgId: (path) Target VPG ID. 

     - returns: RequestBuilder<Void> 
     */
    public class func terminateVirtualPrivateGatewayWithRequestBuilder(vpgId vpgId: String) -> RequestBuilder<Void> {
        var path = "/virtual_private_gateways/{vpgId}/terminate"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Unregister VPG gate peer
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter outerIpAddress: (path) ID of the target node. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func unregisterGatePeer(vpgId vpgId: String, outerIpAddress: String, completion: ((error: ErrorType?) -> Void)) {
        unregisterGatePeerWithRequestBuilder(vpgId: vpgId, outerIpAddress: outerIpAddress).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Unregister VPG gate peer
     
     - DELETE /virtual_private_gateways/{vpgId}/gate/peers/{outerIpAddress}
     - Unregister a gate peer from the Virtual Private Gateway
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter vpgId: (path) Target VPG ID. 
     - parameter outerIpAddress: (path) ID of the target node. 

     - returns: RequestBuilder<Void> 
     */
    public class func unregisterGatePeerWithRequestBuilder(vpgId vpgId: String, outerIpAddress: String) -> RequestBuilder<Void> {
        var path = "/virtual_private_gateways/{vpgId}/gate/peers/{outerIpAddress}"
        path = path.stringByReplacingOccurrencesOfString("{vpgId}", withString: "\(vpgId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{outerIpAddress}", withString: "\(outerIpAddress)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

}