// Request.swift Created by mason on 2016-03-11. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation
import Dispatch


/// The Request class defines and executes a single request to the Soracom API server. Typically, the API request is normally constructed via one of the convenience constructor methods, which takes an appropriate set of zero or more arguments. 
///
/// A Request instance may be executed with `run()`, or else wrapped in an APIOperation object and added to an NSOperationQueue for later execution. 
///
/// The request executes asynchronously, doing its network communication in an arbitrary background thread, and upon completion of the HTTP request, the `ResponseHandler` closure associated with the Request instance is invoked to handle the server's response (or any error that occurred). The response handler is executed on the main thread, for convenience, so things like updating UI may be done without additional work.
///
/// There are two ways to designate a response handler for a request. It's a read-write instance property, so you can simply set it, or supply it as a parameter when initializing a response. It is the last parameter of the various init and constructor methods, so that Swift's convenient trailing closure syntax may be used:
///
///
/// Example:
///
///        let req = Request.createOperator("foo@bar.baz", password: "bacon") { (response) in
///            if response != nil {
///                print("With regret, I must inform you an error occurred: \(response.error)")
///            } else {
///                print("Operator created.")
///            }
///        }
///        req.run()
///
/// ...or:
///
///        let req = Request.createOperator("foo@bar.baz", password: "bacon")
///        req.responseHandler = { (response) in
///            if response != nil {
///                print("With regret, I must inform you an error occurred: \(response.error)")
///            } else {
///                print("Operator created.")
///            }
///        }
///        req.run()
///
/// However, the response handler can also be supplied as an argument to the `run()` method, in which case it
/// takes precedence over any existing `responseHandler` instance property:
///
///     req.run { (response) in
///         // do something different
///     }
///
/// Request instances can be manually run, but often should be performed in a certain sequence, depending on the
/// results of previous requests. In such cases, it can be convenient to use APIOperation to sequentially 
/// execute requests from an NSOperationQueue.

open class BaseRequest {
    
    
    
    /// Registers a handler, which is then executed when every request is run. Intended as a convenience for logging, experimentation, and debugging. The handler will be executed just before the Request makes its HTTP request. Handlers are executed **in an arbitrary thread** in the order they are registered.
    
    open class func beforeRun(_ handler: @escaping RequestWillRunHandler) {
        willRunHandlers.append(handler)
    }
    
    fileprivate static var willRunHandlers: [RequestWillRunHandler] = []
    
    
    /// Registers a handler, which is then executed after every request is run. Intended as a convenience for logging, experimentation, and debugging. The handler will be executed just after the HTTP response has been received (or an error occurs), and immediately before the `responseHandler` executes. Handlers are executed **in an arbitrary thread** in the order they are registered.
    
    open class func afterRun(_ handler: @escaping RequestDidRunHandler) {
        didRunHandlers.append(handler)
    }
    
    fileprivate static var didRunHandlers: [RequestDidRunHandler] = []
    
    /// Set this instance property to provide your own routine to look up the credentials (API Key and API Token that are sent in HTTP headers). This will override any global custom routine you have set, and the default lookup routine.
    
    open var credentialsFinder: CredentialsFinder? = nil
    
    
    /// Set this type property to provide your own routine to look up the credentials (API Key and API Token that are sent in HTTP headers) for **all** Request instances. This will replace the default lookup behavior, and will be used by all subsequently-run Request instances, unless you those instances have their instance-level `credentialsFinder` property set.
    
    public static var credentialsFinder: CredentialsFinder? = nil
    
    /// Returns the unique integer ID of the request.
    
    public let requestId = BaseRequest.nextRequestId
    
    
    /// Reserves and returns the next available unique integer ID.
    
    fileprivate static var nextRequestId: Int64  {
        var result: Int64 = -1
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).sync {
            result = lastRequestId
            lastRequestId += 1
        }
        return result
    }
    fileprivate static var lastRequestId: Int64 = 1
    
    
    /// The host name of the production Soracom API server endpoint.
    
    open class var productionEndpointHost: String {
        return "api.soracom.io";
    }
    
    
    /// The host name of the API sandbox Soracom API server endpoint, used for testing and development.
    
    open class var sandboxEndpointHost: String {
        return "api-sandbox.soracom.io"
        
    }
    
    
    /// The API version, currently should always be left at the default "v1".
    
    open var apiVersionString = "v1"
    
    
    /// By default, the API sandbox endpoint will be used. Set this property to override the default. FIXME: Implement a way to set the global default.
    
    open var endpointHost: String {
        get {
            return self._endpointHost ?? BaseRequest.endpointHost
        }
        set {
            self._endpointHost = newValue
        }
    }
    
    fileprivate var _endpointHost: String? = nil
    
    public static var endpointHost:String = BaseRequest.sandboxEndpointHost
    
    
    /// The credentials object that is used to authorize the API request.
    ///
    /// Directly setting this property on a Request instance is supported, but it may be more convenient to set `credentialsFinder` instead, to supply a lookup routine (either on a Request instance, or on the Request type itself to make it the default for all new instances).
    ///
    /// If this property has not been set, the "default" stored credentials of type .KeyAndToken will normally be used, which may suffice for simple applications.
    
    open var credentials: SoracomCredentials {
        
        get {
            if let finder = self.credentialsFinder {
                
                return finder(self)
                
            } else if let finder = BaseRequest.credentialsFinder {
                
                return finder(self)
                
            } else {
                
                return SoracomCredentials.defaultSavedCredentials()
            }
        }
        
        set {
            let creds = newValue
            credentialsFinder = { (req) in
                return creds
            }
        }
    }
    
    
    /// The HTTP method used to make the request.
    
    open var method = HTTPMethod.post
    
    
    /// Controls whether the key and token are sent in HTTP headers. (It is not normally necessary to explicitly set this property.)
    
    open var shouldSendAPIKeyAndTokenInHTTPHeaders = true
    
    
    /// The message body (if any) of the HTTP request. If this exists, it should contain JSON data. It's generally not necessary to set this directly, because it will happen automatically when using the one of the convenience methods for creating a request.
    
    open var messageBody: Data?
    
    
    /// The URL path, e.g. "/operators/verify". (It is not normally necessary to explicitly set this property, because it will happen automatically when using the one of the convenience methods for creating a request.)
    
    open var path: String = ""
    
    
    /// The query that should be encoded into the URL when built.
    
    open var query: [String:String]? = nil
    
    
    /// If true (the default), the `responseHandler` (if any) will be executed on the main thread. Set to false to disable that (in which case, the handler will be executed on an **arbitrary** thread). The `wait()` method sets this propery to false, so that it can be called in the main thread without deadlocking.
    
    open var handleResponseInMainThread = true
    
    
    /// This property provides access to the request's underlying NSURLRequest object, which is created when `run()` is invoked. It is normally `nil` until then.
    
    open var URLRequest: URLRequest?
    
    
    /// The HTTP status expected to be returned by the underlying HTTP request on success. (FIXME: this should be array; some request types have multiple possible success values.)
    
    open var expectedHTTPStatus: Int = 200
    
    
    /// For human convenience, this returns the Request's underlying NSURLRequest's `HTTPBody` data, interpreted as a UTF-8 string.
    
    open var HTTPBodyText: String? {
        if let data = URLRequest?.httpBody, let text = String(data:data, encoding: String.Encoding.utf8) {
            return text
        }
        return nil
    }
    
    
    /// Returns the complete URL, based on endpointHost, API version, path, and query.
    
    open func buildURL() -> URL {
        
        var urlComponents    = URLComponents()
        urlComponents.scheme = "https";
        urlComponents.host   = endpointHost
        
        var fullPath = ""
        if apiVersionString.count > 0 {
            fullPath += "/" + apiVersionString
        }
        fullPath += path
        urlComponents.path = fullPath
        
        if let query = query {
            var queryItems: [URLQueryItem] = []
            
            let keys = query.keys.sorted()
            // preserve stable order to help test cases
            
            for k in keys {
                if let v = query[k] {
                    let qi = URLQueryItem(name: k, value: v)
                    queryItems.append(qi)
                }
            }
            urlComponents.queryItems = queryItems
        }
        
        if let result = urlComponents.url {
            return result
        } else {
            fatalError("failed to build URL")
        }
    }
    
    
    /// Returns a dictionary that can be used as a Request's query, which will then be converted to a HTTP query string per the Soracom API conventions.
    
    open class func makeQueryDictionaryORIGINAL(tagName: String?              = nil,
                                        tagValue: String?                     = nil,
                                        tagValueMatchMode: TagValueMatchMode? = nil,
                                        statusFilter: [SubscriberStatus]?     = nil,
                                        speedClassFilter: [SpeedClass]?       = nil,
                                        limit: Int?                           = nil,
                                        lastEvaluatedKey: String?             = nil
        
        ) -> [String:String] {
        
        var query: [String:String] = [:]
        
        if let name = tagName, let value = tagValue, let mode = tagValueMatchMode {
            
            query["tag_name"]             = name
            query["tag_value"]            = value
            query["tag_value_match_mode"] = mode.rawValue
        }
        
        if let statusFilter = statusFilter {
            if statusFilter.count > 0 {
                let strings = statusFilter.map {e in e.rawValue}
                query["status_filter"] = strings.joined(separator: "|")
            }
        }
        
        if let speedClassFilter = speedClassFilter {
            if speedClassFilter.count > 0 {
                let strings = speedClassFilter.map {e in e.rawValue}
                query["speed_class_filter"] = strings.joined(separator: "|")
            }
        }
        
        if let limit = limit {
            query["limit"] = String(limit)
        }
        
        
        if let lastEvaluatedKey = lastEvaluatedKey {
            query["last_evaluated_key"] = lastEvaluatedKey
        }
        
        return query
    }
    
    open class func makeQueryDictionary(_ dictionary: [String:Any?]) -> [String:String] {
        
        var query: [String:String] = [:]
        
        for (k,v) in dictionary {
            
            if (v == nil) {
                continue
            }
            
            let key = k.snakeCased
            
            if let value = v as? TagValueMatchMode {
                query[key] = value.rawValue;
            
            } else if let value = v as? [SubscriberStatus] {
                let strings = value.map {e in e.rawValue}
                query[key] = strings.joined(separator: "|")
            
            } else if let value = v as? [SpeedClass] {
                let strings = value.map {e in e.rawValue}
                query[key] = strings.joined(separator: "|")
            
            } else if let value = v as? Int {
                query[key] = String(describing: value)
                
            } else if let value = v as? String {
                query[key] = value
                
            } else {
                query[key] = String(describing: v)
                // This probably won't work. But as of 2018-08-02 we don't have any query types other than the ones handled above.
            }
        }
        
        return query
    }
    

    /// Builds the receiver's underlying NSURLRequest object, which is used when `run()` is invoked. This just builds it and returns the result; it doesn't modify the receiver's `URLRequest` property.
    
    open func buildURLRequest() -> URLRequest {
        
        let URL = buildURL()
        
        #if os(Linux)
        var request = Foundation.URLRequest(url: URL)
        #else
        let request = NSMutableURLRequest(url: URL)
        #endif
        
        request.httpMethod = self.method.rawValue
        
        if let messageBody = messageBody {
            
            request.httpBody = messageBody;
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if (shouldSendAPIKeyAndTokenInHTTPHeaders) {
            let creds = credentials
            request.setValue(creds.apiKey, forHTTPHeaderField: "X-Soracom-API-Key")
            request.setValue(creds.token, forHTTPHeaderField: "X-Soracom-Token")
        }
        
        return request as URLRequest // as? always succeeds on macOS, but always fails on Linux... ;-/
    }
    
    
    /**
     The `whenFinished` action (if one exists) runs after the receiver has `run()` and any response handlers have executed. (Its main purpose is to allow operations that wrap requests to know when they have been fully executed.)
     */
    open func whenFinished(_ action: @escaping WhenFinishedAction) {
        _whenFinished = action;
    }
    internal var _whenFinished : WhenFinishedAction? = nil
    
 
    /**
     BaseRequest's implementation does nothing. Concrete Request<T> types with a type parameter override this to invoke `run()`.
     
     This method exists to allow APIOperation to invoke `Request<T>.run()` without having to know the type of `T`.
    */
    open func invokeRun() {
        
        // Do nothing.
    }
}


open class Request<T>: BaseRequest {
    
    /// The ResponseHandler function that, if it exists, will be use to process the response to the request (or potentially the error that occurred).

    open var responseHandler: ResponseHandler<T>?
    

    /// The basic initializer can be used if (for some reason) you want to create an API request manually. The `path` should begin with "/". It is also possible to supply the `responseHandler` at init time (in which case Swift trailing closure syntax may be used).
    
    public required init(_ path: String, responseHandler: ResponseHandler<T>? = nil) {
        super.init()
        self.path = path
        self.responseHandler = responseHandler
    }
    
    open override func invokeRun() {
        run()
    }

    
    // Mason 2016-06-30: started to implement this, but then I thought maybe actually the request should always run (and get error from server). Not sure yet.
    //    convenience init(clientSideError: APIError, responseHandler: ResponseHandler? = nil) {
    //        self.init("", responseHandler: responseHandler)
    //        self.response = Response(error: clientSideError)
    //    }
    
    
    /// Send the actual request to the API server, asynchronously doing the network request on a background thread, and then invoking `responseHandler` on the main thread after the response is received (or, potentially, when the request times out or an error occurs). If the `responseHandler` argument is non-nil, it will be used and the receiver's `responseHandler` instance property will be ignored.
    ///
    /// (You can opt out of handling the response on the main thread by setting the receiver's `handleResponseInMainThread` property to false.)
    
    open func run(_ responseHandler: ResponseHandler<T>? = nil) {
        
        let urlRequest  = buildURLRequest()
        self.URLRequest = urlRequest

        // FIXME: check for 'no credentials' and error appropriately
        
        for (handler) in type(of: self).willRunHandlers {
            handler(self)
        }
        
        #if os(Linux)
            let sessionConfig = URLSessionConfiguration()
            let session = URLSession(configuration: sessionConfig)
        #else
            let session = URLSession.shared // ← NSUnimplemented() on Linux aotw 2017-07-12
        #endif
        let task = session.dataTask(with: (urlRequest as URLRequest)) { data, httpResponse, error -> Void in
            
            let httpResponse = httpResponse as? HTTPURLResponse
            
            #if !os(Linux)
                let response = Response(request: self, underlyingURLResponse: httpResponse, data: data, underlyingError: error as NSError?)
            #else
                let response = Response(request: self, underlyingURLResponse: httpResponse, data: data, underlyingError: nil)
            #endif

            for (handler) in type(of: self).didRunHandlers {
                handler(response)
            }
            
            if let responseHandler = responseHandler ?? self.responseHandler {
                
                if self.handleResponseInMainThread {
                    DispatchQueue.main.sync {
                        responseHandler(response)
                    }
                } else {
                    responseHandler(response)
                }
            }
            if let f = self._whenFinished {
                f()
            }

        }
        task.resume()
    }
    
    
    /// Run request synchronously, blocking the calling thread until the Response is available. This isn't the most performant way to make a request, and it is [discouraged for various good reasons](https://forums.developer.apple.com/thread/11519), but in some circumstances it may be appropriate and convenient.
    
    open func wait() -> Response<T> {
        
        var result: Response<T>? = nil
        let waitSemaphore     = DispatchSemaphore(value: 0);
        
        handleResponseInMainThread = false
        
        self.run { (response) in
            
            result  = response
            waitSemaphore.signal();
        }
        
        _ = waitSemaphore.wait(timeout: DispatchTime.distantFuture);
        
        guard let response = result else {
            let err = APIError(code: "CLI0666", message: "client-side error: synchronous execution failed")
            return Response<T>(request: self, underlyingURLResponse: nil, data: nil, underlyingError: nil, internalError: err)
        }
        
        return response
    }
    
    
}


// MARK: - CustomStringConvertible

extension Request: CustomStringConvertible {
    
    /// Return attractive and understandable end-user-facing textual representations of the API request. Intended for debugging and learning. (And maybe verbose logging?)

    open var description: String {
        let f = RequestResponseFormatter()
        return f.formatRequest(self)
    }
    
}


// MARK: - typealias definitions

/// RequestBuilder defines a simple closure with no parameters, which returns a Request. This is used by APIOperation to make it simple to queue operations in advance, but defer creation of Request instances until previous requests have run and returned their data.

public typealias RequestBuilder = (() -> BaseRequest)


/// ResponseHandler defines the type of closure that it used to handle the Response object that is the result of running a Request.

public typealias ResponseHandler<T> = ((Response<T>) -> ())


/// See beforeRun().

public typealias RequestWillRunHandler = ((BaseRequest) -> ())


/// See afterRun().

public typealias RequestDidRunHandler = ((BaseResponse) -> ())


/// The CredentialsFinder typealias names a closure that looks up credentials. If the default behavior isn't suitable, client code can provide its own lookup routine, on a per-instance or global basis.

public typealias CredentialsFinder = ((BaseRequest) -> (SoracomCredentials))


/// Defines the type for Request.whenFinished

public typealias WhenFinishedAction = (() -> Void)
