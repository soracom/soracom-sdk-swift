extension Request {

    public class func activatePaymentMethod(
        
        responseHandler: ResponseHandler<[String: Any]>? = nil
    ) ->   Request<[String: Any]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _activatePaymentMethod( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_activatePaymentMethod()) is not sufficient):

        return req
    }
}