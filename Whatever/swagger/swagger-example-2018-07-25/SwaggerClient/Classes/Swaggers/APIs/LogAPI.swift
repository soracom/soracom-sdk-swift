//
// LogAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class LogAPI {
    /**
     * enum for parameter resourceType
     */
    public enum ResourceType_getLogs: String { 
        case subscriber = "Subscriber"
        case eventHandler = "EventHandler"
        case virtualPrivateGateway = "VirtualPrivateGateway"
    }

    /**
     * enum for parameter service
     */
    public enum Service_getLogs: String { 
        case air = "Air"
        case beam = "Beam"
        case canal = "Canal"
        case direct = "Direct"
        case door = "Door"
        case endorse = "Endorse"
        case funnel = "Funnel"
        case gate = "Gate"
    }

    /**
     Get Logs.
     
     - parameter resourceType: (query) Type of the target resource to query log entries. (optional)
     - parameter resourceId: (query) Identity of the target resource to query log entries. (optional)
     - parameter service: (query) Service name to filter log entries. (optional)
     - parameter from: (query) Start time for the log search range (unixtime). (optional)
     - parameter to: (query) End time for the log search range (unixtime). (optional)
     - parameter limit: (query) Maximum number of log entries to retrieve. (optional)
     - parameter lastEvaluatedKey: (query) The value of &#x60;time&#x60; in the last log entry retrieved in the previous page. By specifying this parameter, you can continue to retrieve the list from the next page onward. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getLogs(resourceType: ResourceType_getLogs? = nil, resourceId: String? = nil, service: Service_getLogs? = nil, from: Int? = nil, to: Int? = nil, limit: Int? = nil, lastEvaluatedKey: String? = nil, completion: @escaping ((_ data: [LogEntry]?,_ error: Error?) -> Void)) {
        getLogsWithRequestBuilder(resourceType: resourceType, resourceId: resourceId, service: service, from: from, to: to, limit: limit, lastEvaluatedKey: lastEvaluatedKey).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Get Logs.
     - GET /logs
     - Returns a list of log entries that match certain criteria. If the total number of entries does not fit in one page, a URL for accessing the next page is returned in the 'Link' header of the response.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example=[ {
  "resourceId" : "resourceId",
  "service" : "Air",
  "time" : 0,
  "body" : "{}",
  "resourceType" : "Subscriber"
}, {
  "resourceId" : "resourceId",
  "service" : "Air",
  "time" : 0,
  "body" : "{}",
  "resourceType" : "Subscriber"
} ]}]
     
     - parameter resourceType: (query) Type of the target resource to query log entries. (optional)
     - parameter resourceId: (query) Identity of the target resource to query log entries. (optional)
     - parameter service: (query) Service name to filter log entries. (optional)
     - parameter from: (query) Start time for the log search range (unixtime). (optional)
     - parameter to: (query) End time for the log search range (unixtime). (optional)
     - parameter limit: (query) Maximum number of log entries to retrieve. (optional)
     - parameter lastEvaluatedKey: (query) The value of &#x60;time&#x60; in the last log entry retrieved in the previous page. By specifying this parameter, you can continue to retrieve the list from the next page onward. (optional)

     - returns: RequestBuilder<[LogEntry]> 
     */
    open class func getLogsWithRequestBuilder(resourceType: ResourceType_getLogs? = nil, resourceId: String? = nil, service: Service_getLogs? = nil, from: Int? = nil, to: Int? = nil, limit: Int? = nil, lastEvaluatedKey: String? = nil) -> RequestBuilder<[LogEntry]> {
        let path = "/logs"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "resource_type": resourceType?.rawValue, 
            "resource_id": resourceId, 
            "service": service?.rawValue, 
            "from": from?.encodeToJSON(), 
            "to": to?.encodeToJSON(), 
            "limit": limit?.encodeToJSON(), 
            "last_evaluated_key": lastEvaluatedKey
        ])
        

        let requestBuilder: RequestBuilder<[LogEntry]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
