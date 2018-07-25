//
// LagoonAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class LagoonAPI {
    /**
     Create a SORACOM Lagoon user
     
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createLagoonUser(request: LagoonUserCreationRequest, completion: @escaping ((_ data: LagoonUserCreationResponse?,_ error: Error?) -> Void)) {
        createLagoonUserWithRequestBuilder(request: request).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Create a SORACOM Lagoon user
     - POST /lagoon/users
     - Create a SORACOM Lagoon user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "id" : 0
}}]
     
     - parameter request: (body) request 

     - returns: RequestBuilder<LagoonUserCreationResponse> 
     */
    open class func createLagoonUserWithRequestBuilder(request: LagoonUserCreationRequest) -> RequestBuilder<LagoonUserCreationResponse> {
        let path = "/lagoon/users"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: request)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<LagoonUserCreationResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Delete a SORACOM Lagoon user
     
     - parameter lagoonUserId: (path) Target ID of the lagoon user 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteLagoonUser(lagoonUserId: Int, completion: @escaping ((_ error: Error?) -> Void)) {
        deleteLagoonUserWithRequestBuilder(lagoonUserId: lagoonUserId).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Delete a SORACOM Lagoon user
     - DELETE /lagoon/users/{lagoon_user_id}
     - Delete a SORACOM Lagoon user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter lagoonUserId: (path) Target ID of the lagoon user 

     - returns: RequestBuilder<Void> 
     */
    open class func deleteLagoonUserWithRequestBuilder(lagoonUserId: Int) -> RequestBuilder<Void> {
        var path = "/lagoon/users/{lagoon_user_id}"
        path = path.replacingOccurrences(of: "{lagoon_user_id}", with: "\(lagoonUserId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     List SORACOM Lagoon users that belong to operator
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func listLagoonUsers(completion: @escaping ((_ data: LagoonUser?,_ error: Error?) -> Void)) {
        listLagoonUsersWithRequestBuilder().execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     List SORACOM Lagoon users that belong to operator
     - GET /lagoon/users
     - List SORACOM Lagoon users that belong to operator.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "lastSeenAt" : "lastSeenAt",
  "role" : "Viewer",
  "id" : 0.80082819046101150206595775671303272247314453125,
  "email" : "email"
}}]

     - returns: RequestBuilder<LagoonUser> 
     */
    open class func listLagoonUsersWithRequestBuilder() -> RequestBuilder<LagoonUser> {
        let path = "/lagoon/users"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<LagoonUser>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Register (activate) SORACOM Lagoon
     
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func registerLagoon(request: LagoonRegistrationRequest, completion: @escaping ((_ data: LagoonRegistrationResponse?,_ error: Error?) -> Void)) {
        registerLagoonWithRequestBuilder(request: request).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Register (activate) SORACOM Lagoon
     - POST /lagoon/register
     - Register (activate) SORACOM Lagoon. This API is only allowed to operate by root account.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json, example={
  "lagoonUserEmail" : "lagoonUserEmail"
}}]
     
     - parameter request: (body) request 

     - returns: RequestBuilder<LagoonRegistrationResponse> 
     */
    open class func registerLagoonWithRequestBuilder(request: LagoonRegistrationRequest) -> RequestBuilder<LagoonRegistrationResponse> {
        let path = "/lagoon/register"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: request)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<LagoonRegistrationResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Terminate (deactivate) SORACOM Lagoon
     
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func terminateLagoon(completion: @escaping ((_ error: Error?) -> Void)) {
        terminateLagoonWithRequestBuilder().execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Terminate (deactivate) SORACOM Lagoon
     - POST /lagoon/terminate
     - Terminate (deactivate) SORACOM Lagoon.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token

     - returns: RequestBuilder<Void> 
     */
    open class func terminateLagoonWithRequestBuilder() -> RequestBuilder<Void> {
        let path = "/lagoon/terminate"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Update email address of a SORACOM Lagoon user
     
     - parameter lagoonUserId: (path) Target ID of the lagoon user 
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateLagoonUserEmail(lagoonUserId: Int, request: LagoonUserEmailUpdatingRequest, completion: @escaping ((_ error: Error?) -> Void)) {
        updateLagoonUserEmailWithRequestBuilder(lagoonUserId: lagoonUserId, request: request).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Update email address of a SORACOM Lagoon user
     - PUT /lagoon/users/{lagoon_user_id}/email
     - Update email address of a SORACOM Lagoon user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter lagoonUserId: (path) Target ID of the lagoon user 
     - parameter request: (body) request 

     - returns: RequestBuilder<Void> 
     */
    open class func updateLagoonUserEmailWithRequestBuilder(lagoonUserId: Int, request: LagoonUserEmailUpdatingRequest) -> RequestBuilder<Void> {
        var path = "/lagoon/users/{lagoon_user_id}/email"
        path = path.replacingOccurrences(of: "{lagoon_user_id}", with: "\(lagoonUserId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: request)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Update password of a SORACOM Lagoon user
     
     - parameter lagoonUserId: (path) Target ID of the lagoon user 
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateLagoonUserPassword(lagoonUserId: Int, request: LagoonUserPasswordUpdatingRequest, completion: @escaping ((_ error: Error?) -> Void)) {
        updateLagoonUserPasswordWithRequestBuilder(lagoonUserId: lagoonUserId, request: request).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Update password of a SORACOM Lagoon user
     - PUT /lagoon/users/{lagoon_user_id}/password
     - Update password of a SORACOM Lagoon user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter lagoonUserId: (path) Target ID of the lagoon user 
     - parameter request: (body) request 

     - returns: RequestBuilder<Void> 
     */
    open class func updateLagoonUserPasswordWithRequestBuilder(lagoonUserId: Int, request: LagoonUserPasswordUpdatingRequest) -> RequestBuilder<Void> {
        var path = "/lagoon/users/{lagoon_user_id}/password"
        path = path.replacingOccurrences(of: "{lagoon_user_id}", with: "\(lagoonUserId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: request)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Update permission of a SORACOM Lagoon user
     
     - parameter lagoonUserId: (path) Target ID of the lagoon user 
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateLagoonUserPermission(lagoonUserId: Int, request: LagoonUserPermissionUpdatingRequest, completion: @escaping ((_ error: Error?) -> Void)) {
        updateLagoonUserPermissionWithRequestBuilder(lagoonUserId: lagoonUserId, request: request).execute { (response, error) -> Void in
            completion(error);
        }
    }


    /**
     Update permission of a SORACOM Lagoon user
     - PUT /lagoon/users/{lagoon_user_id}/permission
     - Update permission of a SORACOM Lagoon user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter lagoonUserId: (path) Target ID of the lagoon user 
     - parameter request: (body) request 

     - returns: RequestBuilder<Void> 
     */
    open class func updateLagoonUserPermissionWithRequestBuilder(lagoonUserId: Int, request: LagoonUserPermissionUpdatingRequest) -> RequestBuilder<Void> {
        var path = "/lagoon/users/{lagoon_user_id}/permission"
        path = path.replacingOccurrences(of: "{lagoon_user_id}", with: "\(lagoonUserId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: request)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
