//
// EventHandlerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire



public class EventHandlerAPI: APIBase {
    
    
    
    /**
     
     Create Event Handler.
     
     - parameter req: (body) req 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func createEventHandler(req req: CreateEventHandlerRequest, completion: ((data: EventHandlerModel?, error: ErrorType?) -> Void)) {
        createEventHandlerWithRequestBuilder(req: req).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Create Event Handler.
     
     - POST /event_handlers
     - Creates a new event handler.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example={
  "targetOperatorId" : "aeiou",
  "actionConfigList" : [ {
    "type" : "aeiou",
    "properties" : {
      "headers" : "{}",
      "functionName" : "aeiou",
      "title" : "aeiou",
      "message" : "aeiou",
      "httpMethod" : "aeiou",
      "body" : "aeiou",
      "url" : "aeiou",
      "speedClass" : "aeiou",
      "secretAccessKey" : "aeiou",
      "endpoint" : "aeiou",
      "accessKey" : "aeiou",
      "executionDateTimeConst" : "aeiou",
      "to" : "aeiou",
      "parameter5" : "aeiou",
      "parameter4" : "aeiou",
      "contentType" : "aeiou",
      "parameter3" : "aeiou",
      "parameter2" : "aeiou",
      "parameter1" : "aeiou"
    }
  } ],
  "handlerId" : "aeiou",
  "targetImsi" : "aeiou",
  "name" : "aeiou",
  "description" : "aeiou",
  "targetGroupId" : "aeiou",
  "targetTag" : { },
  "ruleConfig" : {
    "type" : "aeiou",
    "properties" : {
      "inactiveTimeoutDateConst" : "aeiou",
      "targetSpeedClass" : "aeiou",
      "limitTotalTrafficMegaByte" : "",
      "targetStatus" : "aeiou"
    }
  },
  "status" : "aeiou"
}}]
     
     - parameter req: (body) req 

     - returns: RequestBuilder<EventHandlerModel> 
     */
    public class func createEventHandlerWithRequestBuilder(req req: CreateEventHandlerRequest) -> RequestBuilder<EventHandlerModel> {
        let path = "/event_handlers"
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = req.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<EventHandlerModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    /**
     
     Delete Event Handler.
     
     - parameter handlerId: (path) handler ID 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func deleteEventHandler(handlerId handlerId: String, completion: ((error: ErrorType?) -> Void)) {
        deleteEventHandlerWithRequestBuilder(handlerId: handlerId).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Delete Event Handler.
     
     - DELETE /event_handlers/{handlerId}
     - Deletes the specified event handler.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter handlerId: (path) handler ID 

     - returns: RequestBuilder<Void> 
     */
    public class func deleteEventHandlerWithRequestBuilder(handlerId handlerId: String) -> RequestBuilder<Void> {
        var path = "/event_handlers/{handlerId}"
        path = path.stringByReplacingOccurrencesOfString("{handlerId}", withString: "\(handlerId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Delete Ignore Event Handler.
     
     - parameter imsi: (path) imsi 
     - parameter handlerId: (path) handler_id 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func deleteIgnoreEventHandler(imsi imsi: String, handlerId: String, completion: ((error: ErrorType?) -> Void)) {
        deleteIgnoreEventHandlerWithRequestBuilder(imsi: imsi, handlerId: handlerId).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Delete Ignore Event Handler.
     
     - DELETE /event_handlers/{handlerId}/subscribers/{imsi}/ignore
     - Deletes the setting for ignoring the specified event handler of the specified IMSI.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter imsi: (path) imsi 
     - parameter handlerId: (path) handler_id 

     - returns: RequestBuilder<Void> 
     */
    public class func deleteIgnoreEventHandlerWithRequestBuilder(imsi imsi: String, handlerId: String) -> RequestBuilder<Void> {
        var path = "/event_handlers/{handlerId}/subscribers/{imsi}/ignore"
        path = path.stringByReplacingOccurrencesOfString("{imsi}", withString: "\(imsi)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{handlerId}", withString: "\(handlerId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    /**
     
     Get Event Handler.
     
     - parameter handlerId: (path) handler ID 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func getEventHandler(handlerId handlerId: String, completion: ((data: EventHandlerModel?, error: ErrorType?) -> Void)) {
        getEventHandlerWithRequestBuilder(handlerId: handlerId).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Get Event Handler.
     
     - GET /event_handlers/{handlerId}
     - Returns information about the specified event handler.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example={
  "targetOperatorId" : "aeiou",
  "actionConfigList" : [ {
    "type" : "aeiou",
    "properties" : {
      "headers" : "{}",
      "functionName" : "aeiou",
      "title" : "aeiou",
      "message" : "aeiou",
      "httpMethod" : "aeiou",
      "body" : "aeiou",
      "url" : "aeiou",
      "speedClass" : "aeiou",
      "secretAccessKey" : "aeiou",
      "endpoint" : "aeiou",
      "accessKey" : "aeiou",
      "executionDateTimeConst" : "aeiou",
      "to" : "aeiou",
      "parameter5" : "aeiou",
      "parameter4" : "aeiou",
      "contentType" : "aeiou",
      "parameter3" : "aeiou",
      "parameter2" : "aeiou",
      "parameter1" : "aeiou"
    }
  } ],
  "handlerId" : "aeiou",
  "targetImsi" : "aeiou",
  "name" : "aeiou",
  "description" : "aeiou",
  "targetGroupId" : "aeiou",
  "targetTag" : { },
  "ruleConfig" : {
    "type" : "aeiou",
    "properties" : {
      "inactiveTimeoutDateConst" : "aeiou",
      "targetSpeedClass" : "aeiou",
      "limitTotalTrafficMegaByte" : "",
      "targetStatus" : "aeiou"
    }
  },
  "status" : "aeiou"
}}]
     
     - parameter handlerId: (path) handler ID 

     - returns: RequestBuilder<EventHandlerModel> 
     */
    public class func getEventHandlerWithRequestBuilder(handlerId handlerId: String) -> RequestBuilder<EventHandlerModel> {
        var path = "/event_handlers/{handlerId}"
        path = path.stringByReplacingOccurrencesOfString("{handlerId}", withString: "\(handlerId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<EventHandlerModel>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    /**
     * enum for parameter target
     */
    public enum Target_listEventHandlers: String { 
        case Operator = "operator"
        case Imsi = "imsi"
        case Tag = "tag"
        case Group = "group"
    }

    
    
    
    /**
     
     List Event Handlers.
     
     - parameter target: (query) target (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func listEventHandlers(target target: Target_listEventHandlers? = nil, completion: ((data: [EventHandlerModel]?, error: ErrorType?) -> Void)) {
        listEventHandlersWithRequestBuilder(target: target).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     List Event Handlers.
     
     - GET /event_handlers
     - Returns a list of event handlers.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example=[ {
  "targetOperatorId" : "aeiou",
  "actionConfigList" : [ {
    "type" : "aeiou",
    "properties" : {
      "headers" : "{}",
      "functionName" : "aeiou",
      "title" : "aeiou",
      "message" : "aeiou",
      "httpMethod" : "aeiou",
      "body" : "aeiou",
      "url" : "aeiou",
      "speedClass" : "aeiou",
      "secretAccessKey" : "aeiou",
      "endpoint" : "aeiou",
      "accessKey" : "aeiou",
      "executionDateTimeConst" : "aeiou",
      "to" : "aeiou",
      "parameter5" : "aeiou",
      "parameter4" : "aeiou",
      "contentType" : "aeiou",
      "parameter3" : "aeiou",
      "parameter2" : "aeiou",
      "parameter1" : "aeiou"
    }
  } ],
  "handlerId" : "aeiou",
  "targetImsi" : "aeiou",
  "name" : "aeiou",
  "description" : "aeiou",
  "targetGroupId" : "aeiou",
  "targetTag" : { },
  "ruleConfig" : {
    "type" : "aeiou",
    "properties" : {
      "inactiveTimeoutDateConst" : "aeiou",
      "targetSpeedClass" : "aeiou",
      "limitTotalTrafficMegaByte" : "",
      "targetStatus" : "aeiou"
    }
  },
  "status" : "aeiou"
} ]}]
     
     - parameter target: (query) target (optional)

     - returns: RequestBuilder<[EventHandlerModel]> 
     */
    public class func listEventHandlersWithRequestBuilder(target target: Target_listEventHandlers? = nil) -> RequestBuilder<[EventHandlerModel]> {
        let path = "/event_handlers"
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [
            "target": target?.rawValue
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[EventHandlerModel]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    
    
    
    /**
     
     List Event Handlers related to Subscriber.
     
     - parameter imsi: (path) imsi 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func listEventHandlersBySubscriber(imsi imsi: String, completion: ((data: [EventHandlerModel]?, error: ErrorType?) -> Void)) {
        listEventHandlersBySubscriberWithRequestBuilder(imsi: imsi).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     List Event Handlers related to Subscriber.
     
     - GET /event_handlers/subscribers/{imsi}
     - Returns a list of event handlers related to the specified IMSI.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example=[ {
  "targetOperatorId" : "aeiou",
  "actionConfigList" : [ {
    "type" : "aeiou",
    "properties" : {
      "headers" : "{}",
      "functionName" : "aeiou",
      "title" : "aeiou",
      "message" : "aeiou",
      "httpMethod" : "aeiou",
      "body" : "aeiou",
      "url" : "aeiou",
      "speedClass" : "aeiou",
      "secretAccessKey" : "aeiou",
      "endpoint" : "aeiou",
      "accessKey" : "aeiou",
      "executionDateTimeConst" : "aeiou",
      "to" : "aeiou",
      "parameter5" : "aeiou",
      "parameter4" : "aeiou",
      "contentType" : "aeiou",
      "parameter3" : "aeiou",
      "parameter2" : "aeiou",
      "parameter1" : "aeiou"
    }
  } ],
  "handlerId" : "aeiou",
  "targetImsi" : "aeiou",
  "name" : "aeiou",
  "description" : "aeiou",
  "targetGroupId" : "aeiou",
  "targetTag" : { },
  "ruleConfig" : {
    "type" : "aeiou",
    "properties" : {
      "inactiveTimeoutDateConst" : "aeiou",
      "targetSpeedClass" : "aeiou",
      "limitTotalTrafficMegaByte" : "",
      "targetStatus" : "aeiou"
    }
  },
  "status" : "aeiou"
} ]}]
     
     - parameter imsi: (path) imsi 

     - returns: RequestBuilder<[EventHandlerModel]> 
     */
    public class func listEventHandlersBySubscriberWithRequestBuilder(imsi imsi: String) -> RequestBuilder<[EventHandlerModel]> {
        var path = "/event_handlers/subscribers/{imsi}"
        path = path.stringByReplacingOccurrencesOfString("{imsi}", withString: "\(imsi)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[EventHandlerModel]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Ignore Event Handler.
     
     - parameter imsi: (path) imsi 
     - parameter handlerId: (path) handler_id 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func setIgnoreEventHandler(imsi imsi: String, handlerId: String, completion: ((error: ErrorType?) -> Void)) {
        setIgnoreEventHandlerWithRequestBuilder(imsi: imsi, handlerId: handlerId).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Ignore Event Handler.
     
     - POST /event_handlers/{handlerId}/subscribers/{imsi}/ignore
     - Adds a setting for ignoring the specified event handler of the specified IMSI.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter imsi: (path) imsi 
     - parameter handlerId: (path) handler_id 

     - returns: RequestBuilder<Void> 
     */
    public class func setIgnoreEventHandlerWithRequestBuilder(imsi imsi: String, handlerId: String) -> RequestBuilder<Void> {
        var path = "/event_handlers/{handlerId}/subscribers/{imsi}/ignore"
        path = path.stringByReplacingOccurrencesOfString("{imsi}", withString: "\(imsi)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{handlerId}", withString: "\(handlerId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Update Event Handler.
     
     - parameter handlerId: (path) handler ID 
     - parameter eventHandlerModel: (body) eventHandlerModel 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func updateEventHandler(handlerId handlerId: String, eventHandlerModel: UpdateEventHandlerRequest, completion: ((error: ErrorType?) -> Void)) {
        updateEventHandlerWithRequestBuilder(handlerId: handlerId, eventHandlerModel: eventHandlerModel).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Update Event Handler.
     
     - PUT /event_handlers/{handlerId}
     - Updates the specified event handler.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter handlerId: (path) handler ID 
     - parameter eventHandlerModel: (body) eventHandlerModel 

     - returns: RequestBuilder<Void> 
     */
    public class func updateEventHandlerWithRequestBuilder(handlerId handlerId: String, eventHandlerModel: UpdateEventHandlerRequest) -> RequestBuilder<Void> {
        var path = "/event_handlers/{handlerId}"
        path = path.stringByReplacingOccurrencesOfString("{handlerId}", withString: "\(handlerId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = eventHandlerModel.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

}
