extension Request {

    public class func confirmOrder(
        
        orderId: String,
        responseHandler: ResponseHandler<String>? = nil
    ) ->   Request<String> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _confirmOrder(orderId: orderId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_confirmOrder()) is not sufficient):

        return req
    }
}