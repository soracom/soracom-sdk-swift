// APIOperation.swift Created by mason on 2016-04-23. Copyright © 2016 masonmark.com. All rights reserved.

import Foundation


/// The APIOperation class makes it easy to use Request instances with NSOperationQueue. The semantics are
/// similar to Request's `run(_:)` method. There are two typical ways to use APIOperation. The simplest way
/// is to init an APIOperation with a Request instance, and then add the operation to a queue:
///
///     let op = APIOperation(request) {  (response) in
///          
///         // do something with response...
///      }
///     myQueue.addOperation(op);
///
/// However, in many cases, a request will depend on values returned from previous requests. For those cases,
/// you can initialize an APIOperation instance with a RequestBuilder, instead of a Request.
/// 
/// A RequestBuilder is a closure that returns a Request. However, the operation will not execute its
/// RequestBuilder closure, and thereby build the Request, until the operation itself is about to execute.
/// Assuming you use a queue whose `maxConcurrentOperationCount` property is set to `1`, 
/// this means that all previous operations in the queue will have finished before the Request is built.
/// That means you can do things like store a token fetched by a previous request, and then use the token when
/// subsequent operations create their Request objects.
///
/// For example, suppose we want to create an operation that makes a request to verify a token, but we don't
/// yet have the API token. Assuming a preceding operation in the queue will get that token and store it in 
/// the form of a SoracomCredentials object, then we could create an operation that will fetch and use the
/// token to build its own request, like this:
///
///        let builder: RequestBuilder = {
///
///            let creds = SoracomCredentials(withStorageIdentifier: myIdent)
///            return Request.verifyOperator(token: credentials.apiToken)
///        }
///
///        let handler: ResponseHandler = { (response) in
///
///         // do something with response...
///        }
///
///        let verifyOp = APIOperation(builder, completionHandler: handler)
///        queue.addOperation(verifyOp)
///
///
/// APIOperation is implemented as a synchronous operation, intended to be run on a background
/// thread (normally by NSOperationQueue). You can manually `start()` one if you wish, but because
/// Request completion handlers call back to the main thread, you cannot start an APIOperation on
/// the main thread (it will deadlock). They must be started in a background thread.

public class APIOperation: NSOperation {
    
    
    /// Init with a Request instance and the completion handler that should be run by that request. (The completion handler will actually be wrapped in a separate handler that does a bit of additional housekeeping on behalf of the receiver). This is the simple non-deferred case, where the values needed to construct the Request are known up front, and can simply be passed in as parameters.
    
    init(_ request: Request, completionHandler: ResponseHandler? = nil) {
        self.completionHandler = completionHandler
        self.requestBuilder    = { return request }
        super.init()
        
        name = request.path
    }
    
    
    /// The requestBuilder variant inits an operation that defers the creation of its Request object, e.g. because the values needed to contruct the request aren't yet known. In this case, instead of a Request object, a RequestBuilder closure is passed, which will not be executed until the receiver is dequeued. This allows queuing operations which depend on data retrieved by previous operations, before any of the operations have actually executed.
    
    init(_ requestBuilder: RequestBuilder, name: String? = nil, completionHandler: ResponseHandler? = nil) {
        self.completionHandler = completionHandler
        self.requestBuilder    = requestBuilder
        super.init()
        
        self.name = name ?? "APIOperation (deferred Request creation)"
          // Can't set name based on self.request because that would invoke self.requestBuilder (not appropriate at this stage).
          // Someday we might override name to be smart about it, if that proves useful for debugging...
    }
    
    
    /// The completion handler for the request. (APIOperation will actually run the request using its own
    /// handler, which will invoke completionHandler() before doing some additional housekeeping.) // FIXME: shouldn't completionHandler be renamed (project-wide) to responseHandler?
    
    var completionHandler: ResponseHandler? = nil
    

    /// This is synchronous NSOperation subclass, so all work in done in this `main()` method:
    /// - check for cancelled status and abort if cancelled
    /// - run the request (which does networking in a separate, OS-controlled thread)
    /// - wait for the response to (or error result for) the request
    /// - finish

    override public func main() {
        
        guard !self.cancelled else {
            return
        }
        
        let originalHandler = completionHandler
        
        let extendedHandler: ResponseHandler = { (response) in
            
            if let originalHandler = originalHandler {
                originalHandler(response)
            }
            
            dispatch_semaphore_signal(self.semaphore);
        }
        
        request.run(extendedHandler)
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    }
    
    
    // MARK: Internals 
    
    /// Returns the Request instance that this operation will run.
    
    private var request: Request {
        return requestBuilder()
    }
    
    /// The function that builds the request that this operation will run.
    
    private let requestBuilder: RequestBuilder
    
    
    /// Private internal semaphore that lets us suspend this operation's subthread and wait for the signal that the completion handler has been executed (in a separate, arbitrary thread controlled by the OS).
    
    private let semaphore = dispatch_semaphore_create(0);

}
