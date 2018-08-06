// APIOperation.swift Created by mason on 2016-04-23. Copyright © 2016 Soracom, Inc.. All rights reserved.

import Foundation
import Dispatch

/// The APIOperation class makes it easy to use Request instances with NSOperationQueue. 
///
///
/// The simplest way is to init an APIOperation with a Request instance, and then add the operation to a queue:
///
///     let op = APIOperation(request)
///     myQueue.addOperation(op);
///
/// However, in many cases, a request will depend on values returned from previous requests. For those cases,
/// you can initialize an APIOperation instance with a RequestBuilder, instead of a Request.
/// 
/// A RequestBuilder is a closure that returns a Request. However, an APIOperation initialized this way won't
/// execute its RequestBuilder, and thereby build the Request, until the operation itself is about to execute.
/// Assuming you use a queue whose `maxConcurrentOperationCount` property is set to `1`, 
/// this means that all previous operations in the queue will have finished before the Request is built.
///
/// That means you can do things like store a token fetched by a previous request, and then use the token when
/// subsequent operations create their Request objects.
///
/// For example, suppose we want to create an operation that makes a request to verify a token, but we don't
/// yet have the API token. Assuming a preceding operation in the queue will get that token and store it in 
/// the form of a SoracomCredentials object, then we could create an operation that will fetch and use the
/// token to build its own request, like this:
///
///        let verifyOp = APIOperation() {
///
///            let creds = SoracomCredentials(withStorageIdentifier: myIdent)
///            
///            // creds doesn't yet exist when this operation is created and queued...
///
///            let req = Request.verifyOperator(token: credentials.token)
///
///            req.responseHandler = { (response) in
///
///                // do something with response...
///            }
///
///        queue.addOperation(verifyOp)
///
///
/// **Notes:** APIOperation is implemented as a synchronous operation, intended to be run on a background
/// thread (normally by NSOperationQueue). You can manually `start()` one if you wish, but because
/// Request handlers call back to the main thread, you cannot start an APIOperation on
/// the main thread (it will deadlock). They must be started in a background thread.

open class APIOperation: Operation {
    
    
    /// Init with a Request instance that should run when the operation executes. This is the simple non-deferred case, where the values needed to construct the Request are known up front, and can simply be passed in as parameters.
    
    public init(_ request: BaseRequest) {
        
        self.requestBuilder = { return request }
        super.init()
        
        name = request.path
    }
    

    /// The requestBuilder variant inits an operation that defers the creation of its Request object, e.g. because the values needed to contruct the request aren't yet known. In this case, instead of a Request object, a RequestBuilder closure is passed, which will not be executed until the receiver is dequeued. This allows queuing operations which depend on data retrieved by previous operations, before any of the operations have actually executed.
    
    public init(_ requestBuilder: @escaping RequestBuilder) {
        
        self.requestBuilder = requestBuilder
        super.init()
    }
    
    
    /// This is synchronous NSOperation subclass, so all work in done in this `main()` method:
    /// - check for cancelled status and abort if cancelled
    /// - run the request (which does networking in a separate, OS-controlled thread)
    /// - wait for the response to (or error result for) the request
    /// - finish

    override open func main() {
        
        guard !self.isCancelled else {
            return
        }
        
        //        guard  let req = request as? Request<Any> else {
        //            fatalError("darn!")
        //        }
        //
        //        let originalHandler = req.responseHandler
        //
        //        let extendedHandler: ResponseHandler<Any> = { (response) in
        //
        //            if let originalHandler = originalHandler {
        //                originalHandler(response)
        //            }
        //
        //            self.semaphore.signal();
        //        }
        //
        //        req.run(extendedHandler)
        
        
        
        request.whenFinished {
            self.semaphore.signal();
        }
        request.runToTheHills()
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture);
    }
    
    
    // MARK: Internals 
    
    /// Returns the Request instance that this operation will run.
    
    private var request: BaseRequest {
        return requestBuilder()
    }
    
    
    /// The function that builds the request that this operation will run.
    
    private let requestBuilder: RequestBuilder
    
    
    /// Private internal semaphore that lets us suspend this operation's subthread and wait for the signal that the response handler has been executed (in a separate, arbitrary thread controlled by the OS).
    
    private let semaphore = DispatchSemaphore(value: 0);

}
