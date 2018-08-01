extension Request {

    public class func cancelOrder(
        
        orderId: String,
        responseHandler: ResponseHandler<String>? = nil
    ) ->   Request<String> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _cancelOrder(orderId: orderId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_cancelOrder()) is not sufficient):

        return req
    }
}