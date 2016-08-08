//
// StatsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire



public class StatsAPI: APIBase {
    
    
    
    
    
    /**
     
     Export Air Usage Report of All Subscribers.
     
     - parameter operatorId: (path) operator ID 
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func exportAirStats(operatorId operatorId: String, request: ExportRequest, completion: ((data: FileOutputResult?, error: ErrorType?) -> Void)) {
        exportAirStatsWithRequestBuilder(operatorId: operatorId, request: request).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Export Air Usage Report of All Subscribers.
     
     - POST /stats/air/operators/{operatorId}/export
     - Retrieves a file containing the usage report of all subscribers for the specified operator. The report data range is specified with from, to in unixtime. The report contains monthly data. The file output destination is AWS S3. The file output format is CSV.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "url" : "aeiou"
}}]
     
     - parameter operatorId: (path) operator ID 
     - parameter request: (body) request 

     - returns: RequestBuilder<FileOutputResult> 
     */
    public class func exportAirStatsWithRequestBuilder(operatorId operatorId: String, request: ExportRequest) -> RequestBuilder<FileOutputResult> {
        var path = "/stats/air/operators/{operatorId}/export"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = request.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<FileOutputResult>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Export Beam Usage Report of All Subscribers.
     
     - parameter operatorId: (path) operator ID 
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func exportBeamStats(operatorId operatorId: String, request: ExportRequest, completion: ((data: FileOutputResult?, error: ErrorType?) -> Void)) {
        exportBeamStatsWithRequestBuilder(operatorId: operatorId, request: request).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Export Beam Usage Report of All Subscribers.
     
     - POST /stats/beam/operators/{operatorId}/export
     - Retrieves a file containing the usage report of all subscribers for the specified operator. The report data range is specified with from, to in unixtime. The report contains monthly data. The file output destination is AWS S3. The file output format is CSV.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "url" : "aeiou"
}}]
     
     - parameter operatorId: (path) operator ID 
     - parameter request: (body) request 

     - returns: RequestBuilder<FileOutputResult> 
     */
    public class func exportBeamStatsWithRequestBuilder(operatorId operatorId: String, request: ExportRequest) -> RequestBuilder<FileOutputResult> {
        var path = "/stats/beam/operators/{operatorId}/export"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = request.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<FileOutputResult>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    
    
    
    
    /**
     * enum for parameter period
     */
    public enum Period_getAirStats: String { 
        case Month = "month"
        case Day = "day"
        case Minutes = "minutes"
    }

    
    
    
    /**
     
     Get Air Usage Report of Subscriber.
     
     - parameter imsi: (path) imsi 
     - parameter from: (query) Start time in unixtime for the aggregate data. 
     - parameter to: (query) End time in unixtime for the aggregate data. 
     - parameter period: (query) Units of aggregate data. For minutes, the interval is every 5 minutes. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func getAirStats(imsi imsi: String, from: Int, to: Int, period: Period_getAirStats, completion: ((data: [AirStatsResponse]?, error: ErrorType?) -> Void)) {
        getAirStatsWithRequestBuilder(imsi: imsi, from: from, to: to, period: period).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Get Air Usage Report of Subscriber.
     
     - GET /stats/air/subscribers/{imsi}
     - Retrieves the usage report for the subscriber specified by the IMSI.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example=[ {
  "date" : "aeiou",
  "unixtime" : 123456789,
  "dataTrafficStatsMap" : {
    "key" : {
      "downloadPacketSizeTotal" : 123456789,
      "uploadByteSizeTotal" : 123456789,
      "uploadPacketSizeTotal" : 123456789,
      "downloadByteSizeTotal" : 123456789
    }
  }
} ]}]
     
     - parameter imsi: (path) imsi 
     - parameter from: (query) Start time in unixtime for the aggregate data. 
     - parameter to: (query) End time in unixtime for the aggregate data. 
     - parameter period: (query) Units of aggregate data. For minutes, the interval is every 5 minutes. 

     - returns: RequestBuilder<[AirStatsResponse]> 
     */
    public class func getAirStatsWithRequestBuilder(imsi imsi: String, from: Int, to: Int, period: Period_getAirStats) -> RequestBuilder<[AirStatsResponse]> {
        var path = "/stats/air/subscribers/{imsi}"
        path = path.stringByReplacingOccurrencesOfString("{imsi}", withString: "\(imsi)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [
            "from": from,
            "to": to,
            "period": period.rawValue
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[AirStatsResponse]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

    
    
    
    
    
    
    
    
    
    /**
     * enum for parameter period
     */
    public enum Period_getBeamStats: String { 
        case Month = "month"
        case Day = "day"
        case Minutes = "minutes"
    }

    
    
    
    /**
     
     Get Beam Usage Report of Subscriber.
     
     - parameter imsi: (path) imsi 
     - parameter from: (query) Start time in unixtime for the aggregate data. 
     - parameter to: (query) End time in unixtime for the aggregate data. 
     - parameter period: (query) Units of aggregate data. For minutes, the interval is every 5 minutes. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func getBeamStats(imsi imsi: String, from: Int, to: Int, period: Period_getBeamStats, completion: ((data: [BeamStatsResponse]?, error: ErrorType?) -> Void)) {
        getBeamStatsWithRequestBuilder(imsi: imsi, from: from, to: to, period: period).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Get Beam Usage Report of Subscriber.
     
     - GET /stats/beam/subscribers/{imsi}
     - Retrieves the Soracom Beam usage report for the subscriber specified by the IMSI.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example=[ {
  "date" : "aeiou",
  "unixtime" : 123456789,
  "beamStatsMap" : {
    "key" : {
      "count" : 123456789
    }
  }
} ]}]
     
     - parameter imsi: (path) imsi 
     - parameter from: (query) Start time in unixtime for the aggregate data. 
     - parameter to: (query) End time in unixtime for the aggregate data. 
     - parameter period: (query) Units of aggregate data. For minutes, the interval is every 5 minutes. 

     - returns: RequestBuilder<[BeamStatsResponse]> 
     */
    public class func getBeamStatsWithRequestBuilder(imsi imsi: String, from: Int, to: Int, period: Period_getBeamStats) -> RequestBuilder<[BeamStatsResponse]> {
        var path = "/stats/beam/subscribers/{imsi}"
        path = path.stringByReplacingOccurrencesOfString("{imsi}", withString: "\(imsi)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [
            "from": from,
            "to": to,
            "period": period.rawValue
        ]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[BeamStatsResponse]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: false)
    }

}
