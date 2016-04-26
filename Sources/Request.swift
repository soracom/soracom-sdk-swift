// Request.swift Created by mason on 2016-03-11. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


/// The Request class defines and executes a single request to the Soracom API server. Typically, the API request is normally constructed via one of the convenience constructor methods, which takes an appropriate set of zero or more arguments, and the request is then executed with `run()`. The request executes asynchronously, and upon completion of the HTTP request, the `ResponseHandler` closure passed to `run()` is invoked to handle the server's response (or any error that occurred).
///
///
/// Example:
///
///        let req = Request.createOperator("foo@bar.baz", password: "bacon")
///        req.run { (response) in
///            if response != nil {
///                print("With regret, I must inform you an error occurred: \(response.error)")
///            } else {
///                print("Operator created.")
///            }
///        }

public class Request {
    
    /// The URL of the production Soracom API server endpoint.
    
    static let productionEndpoint = "https://api.soracom.io"
    
    
    /// The URL of the API sandbox Soracom API server endpoint, used for testing and development.
    
    static let sandboxEndpoint = "https://api-sandbox.soracom.io"
    
    
    /// The API version, currently should always be left at the default "v1".
    
    var apiVersionString = "v1"
    
 
    /// By default, the API sandbox endpoint will be used. Set this property to override the default. FIXME: Implement a way to set the global default.
    
    var endpoint: String {
        get {
            return _endpoint ?? self.dynamicType.sandboxEndpoint
        }
        set {
            _endpoint = newValue
        }
    }
    
    private var _endpoint: String? = nil
    
    
    /// The credentials object that is used to authorize the API request.
    ///
    /// Directly setting this property on a Request instance is supported, but it may be more convenient to set `credentialsFinder` instead, to supply a lookup routine (either on a Request instance, or on the Request type itself to make it the default for all new instances).
    ///
    /// If this property has not been set, the "default" stored credentials of type .KeyAndToken will normally be used, which may suffice for simple applications.

    var credentials: SoracomCredentials {
        
        get {
            if let finder = self.credentialsFinder {
                
                return finder(self)
                
            } else if let finder = Request.credentialsFinder {
                
                return finder(self)
                
            } else {
                
                return SoracomCredentials(withStoredType: .KeyAndToken)
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
    
    var method = HTTPMethod.POST
    
    
    /// Controls whether the key and token are sent in HTTP headers. (It is not normally necessary to explicitly set this property.)
    
    var shouldSendAPIKeyAndTokenInHTTPHeaders = true
    
    
    /// Many API requests have a payload of keys and values that are sent to the server in the HTTP body of the request. The `requestPayload` property contains those values. (It is not normally necessary to explicitly set this property, because it will happen automatically when using the one of the convenience methods for creating a request.) This list will be converted to a JSON object when being sent to the server.
    
    var requestPayload: Payload?
    
    /// The URL path, e.g. "/operators/verify". (It is not normally necessary to explicitly set this property, because it will happen automatically when using the one of the convenience methods for creating a request.)
    
    let path: String
    
    
    /// This property provides access to the request's underlying NSURLRequest object, which is created when `run()` is invoked. It is normally `nil` until then.
    
    var URLRequest: NSMutableURLRequest?
    

    /// The HTTP status expected to be returned by the underlying HTTP request on success. (FIXME: this should be array; some request types have multiple possible success values.)
    
    var expectedHTTPStatus: Int = 200
    
    
    /// For human convenience, this returns the Request's underlying NSURLRequest's `HTTPBody` data, interpreted as a UTF-8 string.
    
    var HTTPBodyText: String? {
        if let data = URLRequest?.HTTPBody, text = String(data:data, encoding: NSUTF8StringEncoding) {
            return text
        }
        return nil
    }

    
    /// An array of keys indicating the values the response payload **must** have to be considered successful. // FIXME: this responsibility should probably be delegated to Payload, and this should then become something like `expectedPayloadTypes`.
    
    var expectedResponseKeys: [String] = []
    
    
    /// The basic initializer can be used if (for some reason) you want to create an API request manually. The `path` should begin with "/".
    
    public required init(_ path: String) {
        self.path = path
    }
    
    
    /// Returns the complete URL, based on endpoint, API version, and path.
    
    func buildURL() -> NSURL {
        
        //        let baseURL    = NSURL(string: endpoint)
        //        let versionURL = NSURL(string: "\(apiVersionString)/", relativeToURL:  baseURL)
        //        let fullURL    = NSURL(string: path, relativeToURL: versionURL)
        // Mason 2016-04-12: someday it might be better to use something like the above; for now we just hack a string.
        
        var urlString = endpoint
        if apiVersionString != "" {
            urlString += "/"
            urlString += apiVersionString
        }
        if !path.hasPrefix("/") {
            urlString += "/"
            // Mason 2016-04-12: I think we should probably just require path to start with '/', or prohibit it. This smells.
        }
        urlString += path
        
        
        if let result = NSURL(string: urlString) {
            return result
        } else {
            fatalError("failed to build URL")
        }
    }
    
    
    /// Send the actual request to the API server, asynchronously doing the network request on a background thread, and then invoking `completionHandler` on the main thread after the response is received (or, potentially, when the request times out or an error occurs).
    
    func run(completionHandler: ResponseHandler? = nil) {
        
        let urlRequest  = buildURLRequest()
        self.URLRequest = urlRequest

        // FIXME: check for 'no credentials' and error appropriately
        
        for (handler) in self.dynamicType.willRunHandlers {
            handler(self)
        }

        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) { data, httpResponse, error -> Void in
            
            let httpResponse = httpResponse as? NSHTTPURLResponse
            
            var response = Response(request: self, underlyingURLResponse: httpResponse, data: data)
        
            if let error = error {
                response.error = APIError(underlyingError: error)
            }
            
            for (handler) in self.dynamicType.didRunHandlers {
                handler(response)
            }
            
            if let completionHandler = completionHandler {
                dispatch_sync(dispatch_get_main_queue()) {
                    completionHandler(response)
                }                
            }
        }
        task.resume()
    }
    
    
    /// Registers a handler, which is then executed when every request is run. Intended as a convenience for logging, experimentation, and debugging. The handler will be executed just before the Request makes its HTTP request. Handlers are executed **in an arbitrary thread** in the order they are registered.
    
    public static func beforeRun(handler: RequestWillRunHandler) {
        willRunHandlers.append(handler)
    }
    
    private static var willRunHandlers: [RequestWillRunHandler] = []

    
    /// Registers a handler, which is then executed after every request is run. Intended as a convenience for logging, experimentation, and debugging. The handler will be executed just after the HTTP response has been received (or an error occurs), and immediately before the `completionHandler` executes. Handlers are executed **in an arbitrary thread** in the order they are registered.

    public static func afterRun(handler: RequestDidRunHandler) {
        didRunHandlers.append(handler)
    }
    
    private static var didRunHandlers: [RequestDidRunHandler] = []
    
    
    /// Builds the receiver's underlying NSURLRequest object, which is used when `run()` is invoked. This just builds it and returns the result; it doesn't modify the receiver's `URLRequest` property.
    
    func buildURLRequest() -> NSMutableURLRequest {
        
        let URL = buildURL()
        
        let request = NSMutableURLRequest(URL: URL)
        
        request.HTTPMethod = self.method.rawValue
        
        if let requestPayload = requestPayload
        {
            request.HTTPBody = requestPayload.toJSONData()
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if (shouldSendAPIKeyAndTokenInHTTPHeaders) {
            let creds = credentials
            request.setValue(creds.apiKey, forHTTPHeaderField: "X-Soracom-API-Key")
            request.setValue(creds.apiToken, forHTTPHeaderField: "X-Soracom-Token")
        }
        
        return request
    }
    
    
    /// Set this instance property to provide your own routine to look up the credentials (API Key and API Token that are sent in HTTP headers). This will override any global custom routine you have set, and the default lookup routine.
    
    var credentialsFinder: CredentialsFinder? = nil
    
    
    /// Set this type property to provide your own routine to look up the credentials (API Key and API Token that are sent in HTTP headers) for **all** Request instances. This will replace the default lookup behavior, and will be used by all subsequently-run Request instances, unless you those instances have their instance-level `credentialsFinder` property set.
    
    public static var credentialsFinder: CredentialsFinder? = nil

    
    /// Returns the unique integer ID of the request.
    
    public let requestId = Request.nextRequestId
    
    
    /// Reserves and returns the next available unique integer ID.
    
    private static var nextRequestId: Int64  {
        var result: Int64 = -1
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            result = lastRequestId
            lastRequestId += 1
        }
        return result
    }
    private static var lastRequestId: Int64 = 1
    
    
}


// MARK: - CustomStringConvertible

extension Request: CustomStringConvertible {
    
    /// Return attractive and understandable end-user-facing textual representations of the API request. Intended for debugging and learning. (And maybe verbose logging?)

    public var description: String {
        let f = RequestResponseFormatter()
        return f.formatRequest(self)
    }
    
    

}


// MARK: - typealias definitions

/// ResponseHandler defines the type of closure that it used to handle the Response object that is the result of running a Request.

public typealias ResponseHandler = ((Response) -> ())


/// See beforeRun().

public typealias RequestWillRunHandler = ((Request) -> ())


/// See afterRun().

public typealias RequestDidRunHandler = ((Response) -> ())


/// The CredentialsFinder typealias names a closure that looks up credentials. If the default behavior isn't suitable, client code can provide its own lookup routine, on a per-instance or global basis.

public typealias CredentialsFinder = ((Request) -> (SoracomCredentials))
