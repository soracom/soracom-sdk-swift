extension Request where T == CreateSubscriberResponse {

    /// Create a sandbox subscriber (a fake SIM for testing). ([Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Subscriber/createSandboxSubscriber))

    public class func createSandboxSubscriberFIXME(
        
        // FIXME: do we need that manual step at the end?
        
        responseHandler: ResponseHandler<CreateSubscriberResponse>? = nil
    ) ->   Request<CreateSubscriberResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = createSandboxSubscriber( responseHandler: responseHandler)

        req.shouldSendAPIKeyAndTokenInHTTPHeaders = false
          // FIXME: this is an unusual case, for us, but check if Swagger can detect this and do it in the auto-generated code (I think it can)

        return req
    }
}
