//
// UserAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Alamofire



public class UserAPI: APIBase {
    
    
    
    
    
    
    
    /**
     
     Create User.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func createUser(operatorId operatorId: String, userName: String, request: CreateUserRequest, completion: ((error: ErrorType?) -> Void)) {
        createUserWithRequestBuilder(operatorId: operatorId, userName: userName, request: request).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Create User.
     
     - POST /operators/{operatorId}/users/{userName}
     - Adds a new SAM user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter request: (body) request 

     - returns: RequestBuilder<Void> 
     */
    public class func createUserWithRequestBuilder(operatorId operatorId: String, userName: String, request: CreateUserRequest) -> RequestBuilder<Void> {
        var path = "/operators/{operatorId}/users/{userName}"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = request.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    
    
    /**
     
     Create Password.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func createUserPassword(operatorId operatorId: String, userName: String, request: CreateUserPasswordRequest, completion: ((error: ErrorType?) -> Void)) {
        createUserPasswordWithRequestBuilder(operatorId: operatorId, userName: userName, request: request).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Create Password.
     
     - POST /operators/{operatorId}/users/{userName}/password
     - Creates a password for the SAM user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter request: (body) request 

     - returns: RequestBuilder<Void> 
     */
    public class func createUserPasswordWithRequestBuilder(operatorId operatorId: String, userName: String, request: CreateUserPasswordRequest) -> RequestBuilder<Void> {
        var path = "/operators/{operatorId}/users/{userName}/password"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = request.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Delete User.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func deleteUser(operatorId operatorId: String, userName: String, completion: ((error: ErrorType?) -> Void)) {
        deleteUserWithRequestBuilder(operatorId: operatorId, userName: userName).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Delete User.
     
     - DELETE /operators/{operatorId}/users/{userName}
     - Deletes the SAM user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 

     - returns: RequestBuilder<Void> 
     */
    public class func deleteUserWithRequestBuilder(operatorId operatorId: String, userName: String) -> RequestBuilder<Void> {
        var path = "/operators/{operatorId}/users/{userName}"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    
    
    /**
     
     Delete User AuthKey.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter authKeyId: (path) auth_key_id 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func deleteUserAuthKey(operatorId operatorId: String, userName: String, authKeyId: String, completion: ((error: ErrorType?) -> Void)) {
        deleteUserAuthKeyWithRequestBuilder(operatorId: operatorId, userName: userName, authKeyId: authKeyId).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Delete User AuthKey.
     
     - DELETE /operators/{operatorId}/users/{userName}/auth_keys/{authKeyId}
     - Deletes an AuthKey from the SAM user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter authKeyId: (path) auth_key_id 

     - returns: RequestBuilder<Void> 
     */
    public class func deleteUserAuthKeyWithRequestBuilder(operatorId operatorId: String, userName: String, authKeyId: String) -> RequestBuilder<Void> {
        var path = "/operators/{operatorId}/users/{userName}/auth_keys/{authKeyId}"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{authKeyId}", withString: "\(authKeyId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Delete Password.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func deleteUserPassword(operatorId operatorId: String, userName: String, completion: ((error: ErrorType?) -> Void)) {
        deleteUserPasswordWithRequestBuilder(operatorId: operatorId, userName: userName).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Delete Password.
     
     - DELETE /operators/{operatorId}/users/{userName}/password
     - Deletes the user's password.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 

     - returns: RequestBuilder<Void> 
     */
    public class func deleteUserPasswordWithRequestBuilder(operatorId operatorId: String, userName: String) -> RequestBuilder<Void> {
        var path = "/operators/{operatorId}/users/{userName}/password"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "DELETE", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Generate AuthKey.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func generateUserAuthKey(operatorId operatorId: String, userName: String, completion: ((data: GenerateUserAuthKeyResponse?, error: ErrorType?) -> Void)) {
        generateUserAuthKeyWithRequestBuilder(operatorId: operatorId, userName: userName).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Generate AuthKey.
     
     - POST /operators/{operatorId}/users/{userName}/auth_keys
     - Generates an AuthKey for the SAM user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example={
  "authKey" : "aeiou",
  "authKeyId" : "aeiou"
}}]
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 

     - returns: RequestBuilder<GenerateUserAuthKeyResponse> 
     */
    public class func generateUserAuthKeyWithRequestBuilder(operatorId operatorId: String, userName: String) -> RequestBuilder<GenerateUserAuthKeyResponse> {
        var path = "/operators/{operatorId}/users/{userName}/auth_keys"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<GenerateUserAuthKeyResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Get User.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func getUser(operatorId operatorId: String, userName: String, completion: ((data: UserDetailResponse?, error: ErrorType?) -> Void)) {
        getUserWithRequestBuilder(operatorId: operatorId, userName: userName).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Get User.
     
     - GET /operators/{operatorId}/users/{userName}
     - Returns a SAM user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example={
  "description" : "aeiou",
  "authKeyList" : [ {
    "authKeyId" : "aeiou",
    "lastUsedDateTime" : 123456789,
    "createDateTime" : 123456789
  } ],
  "permission" : "aeiou",
  "hasPassword" : true,
  "roleList" : [ {
    "roleId" : "aeiou",
    "description" : "aeiou",
    "updateDateTime" : 123456789,
    "createDateTime" : 123456789
  } ],
  "updateDateTime" : 123456789,
  "userName" : "aeiou",
  "createDateTime" : 123456789
}}]
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 

     - returns: RequestBuilder<UserDetailResponse> 
     */
    public class func getUserWithRequestBuilder(operatorId operatorId: String, userName: String) -> RequestBuilder<UserDetailResponse> {
        var path = "/operators/{operatorId}/users/{userName}"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<UserDetailResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    
    
    /**
     
     Get AuthKey.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter authKeyId: (path) auth_key_id 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func getUserAuthKey(operatorId operatorId: String, userName: String, authKeyId: String, completion: ((data: AuthKeyResponse?, error: ErrorType?) -> Void)) {
        getUserAuthKeyWithRequestBuilder(operatorId: operatorId, userName: userName, authKeyId: authKeyId).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Get AuthKey.
     
     - GET /operators/{operatorId}/users/{userName}/auth_keys/{authKeyId}
     - Returns the SAM user's AuthKey.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example={
  "authKeyId" : "aeiou",
  "lastUsedDateTime" : 123456789,
  "createDateTime" : 123456789
}}]
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter authKeyId: (path) auth_key_id 

     - returns: RequestBuilder<AuthKeyResponse> 
     */
    public class func getUserAuthKeyWithRequestBuilder(operatorId operatorId: String, userName: String, authKeyId: String) -> RequestBuilder<AuthKeyResponse> {
        var path = "/operators/{operatorId}/users/{userName}/auth_keys/{authKeyId}"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{authKeyId}", withString: "\(authKeyId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<AuthKeyResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Get User Permission.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func getUserPermission(operatorId operatorId: String, userName: String, completion: ((data: GetUserPermissionResponse?, error: ErrorType?) -> Void)) {
        getUserPermissionWithRequestBuilder(operatorId: operatorId, userName: userName).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Get User Permission.
     
     - GET /operators/{operatorId}/users/{userName}/permission
     - Retrieves the SAM user's permissions.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example={
  "permission" : "aeiou"
}}]
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 

     - returns: RequestBuilder<GetUserPermissionResponse> 
     */
    public class func getUserPermissionWithRequestBuilder(operatorId operatorId: String, userName: String) -> RequestBuilder<GetUserPermissionResponse> {
        var path = "/operators/{operatorId}/users/{userName}/permission"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<GetUserPermissionResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     Has User Password.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func hasUserPassword(operatorId operatorId: String, userName: String, completion: ((data: GetUserPasswordResponse?, error: ErrorType?) -> Void)) {
        hasUserPasswordWithRequestBuilder(operatorId: operatorId, userName: userName).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     Has User Password.
     
     - GET /operators/{operatorId}/users/{userName}/password
     - Retrieves whether the SAM user has a password or not.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example={
  "hasPassword" : true
}}]
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 

     - returns: RequestBuilder<GetUserPasswordResponse> 
     */
    public class func hasUserPasswordWithRequestBuilder(operatorId operatorId: String, userName: String) -> RequestBuilder<GetUserPasswordResponse> {
        var path = "/operators/{operatorId}/users/{userName}/password"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<GetUserPasswordResponse>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    /**
     
     List User AuthKeys.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func listUserAuthKeys(operatorId operatorId: String, userName: String, completion: ((data: [AuthKeyResponse]?, error: ErrorType?) -> Void)) {
        listUserAuthKeysWithRequestBuilder(operatorId: operatorId, userName: userName).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     List User AuthKeys.
     
     - GET /operators/{operatorId}/users/{userName}/auth_keys
     - Returns the SAM user's AuthKey list.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example=[ {
  "authKeyId" : "aeiou",
  "lastUsedDateTime" : 123456789,
  "createDateTime" : 123456789
} ]}]
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 

     - returns: RequestBuilder<[AuthKeyResponse]> 
     */
    public class func listUserAuthKeysWithRequestBuilder(operatorId operatorId: String, userName: String) -> RequestBuilder<[AuthKeyResponse]> {
        var path = "/operators/{operatorId}/users/{userName}/auth_keys"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[AuthKeyResponse]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    /**
     
     List Users.
     
     - parameter operatorId: (path) operator_id 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func listUsers(operatorId operatorId: String, completion: ((data: [UserDetailResponse]?, error: ErrorType?) -> Void)) {
        listUsersWithRequestBuilder(operatorId: operatorId).execute { (response, error) -> Void in
            completion(data: response?.body, error: error);
        }
    }


    /**
     
     List Users.
     
     - GET /operators/{operatorId}/users
     - Returns a list of SAM users.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     - examples: [{contentType=application/json;charset=UTF-8, example=[ {
  "description" : "aeiou",
  "authKeyList" : [ {
    "authKeyId" : "aeiou",
    "lastUsedDateTime" : 123456789,
    "createDateTime" : 123456789
  } ],
  "permission" : "aeiou",
  "hasPassword" : true,
  "roleList" : [ {
    "roleId" : "aeiou",
    "description" : "aeiou",
    "updateDateTime" : 123456789,
    "createDateTime" : 123456789
  } ],
  "updateDateTime" : 123456789,
  "userName" : "aeiou",
  "createDateTime" : 123456789
} ]}]
     
     - parameter operatorId: (path) operator_id 

     - returns: RequestBuilder<[UserDetailResponse]> 
     */
    public class func listUsersWithRequestBuilder(operatorId operatorId: String) -> RequestBuilder<[UserDetailResponse]> {
        var path = "/operators/{operatorId}/users"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let nillableParameters: [String:AnyObject?] = [:]
 
        let parameters = APIHelper.rejectNil(nillableParameters)
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<[UserDetailResponse]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    
    
    /**
     
     Update User.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func updateUser(operatorId operatorId: String, userName: String, request: UpdateUserRequest, completion: ((error: ErrorType?) -> Void)) {
        updateUserWithRequestBuilder(operatorId: operatorId, userName: userName, request: request).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Update User.
     
     - PUT /operators/{operatorId}/users/{userName}
     - Updates the SAM user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter request: (body) request 

     - returns: RequestBuilder<Void> 
     */
    public class func updateUserWithRequestBuilder(operatorId operatorId: String, userName: String, request: UpdateUserRequest) -> RequestBuilder<Void> {
        var path = "/operators/{operatorId}/users/{userName}"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = request.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    
    
    /**
     
     Update Password.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func updateUserPassword(operatorId operatorId: String, userName: String, request: UpdatePasswordRequest, completion: ((error: ErrorType?) -> Void)) {
        updateUserPasswordWithRequestBuilder(operatorId: operatorId, userName: userName, request: request).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Update Password.
     
     - PUT /operators/{operatorId}/users/{userName}/password
     - Updates the password of the SAM user.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter request: (body) request 

     - returns: RequestBuilder<Void> 
     */
    public class func updateUserPasswordWithRequestBuilder(operatorId operatorId: String, userName: String, request: UpdatePasswordRequest) -> RequestBuilder<Void> {
        var path = "/operators/{operatorId}/users/{userName}/password"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = request.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

    
    
    
    
    
    
    
    /**
     
     Update Permission to User.
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter request: (body) request 
     - parameter completion: completion handler to receive the data and the error objects
     */
    public class func updateUserPermission(operatorId operatorId: String, userName: String, request: SetUserPermissionRequest, completion: ((error: ErrorType?) -> Void)) {
        updateUserPermissionWithRequestBuilder(operatorId: operatorId, userName: userName, request: request).execute { (response, error) -> Void in
            completion(error: error);
        }
    }


    /**
     
     Update Permission to User.
     
     - PUT /operators/{operatorId}/users/{userName}/permission
     - Updates the SAM user's permissions.
     - API Key:
       - type: apiKey X-Soracom-API-Key 
       - name: api_key
     - API Key:
       - type: apiKey X-Soracom-Token 
       - name: api_token
     
     - parameter operatorId: (path) operator_id 
     - parameter userName: (path) user_name 
     - parameter request: (body) request 

     - returns: RequestBuilder<Void> 
     */
    public class func updateUserPermissionWithRequestBuilder(operatorId operatorId: String, userName: String, request: SetUserPermissionRequest) -> RequestBuilder<Void> {
        var path = "/operators/{operatorId}/users/{userName}/permission"
        path = path.stringByReplacingOccurrencesOfString("{operatorId}", withString: "\(operatorId)", options: .LiteralSearch, range: nil)
        path = path.stringByReplacingOccurrencesOfString("{userName}", withString: "\(userName)", options: .LiteralSearch, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        
        let parameters = request.encodeToJSON() as? [String:AnyObject]
 
        let convertedParameters = APIHelper.convertBoolToString(parameters)
 
        let requestBuilder: RequestBuilder<Void>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: URLString, parameters: convertedParameters, isBody: true)
    }

}
