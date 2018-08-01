extension Request {

    public class func registerOrderedSim(
        
        orderId: String,
        responseHandler: ResponseHandler<String>? = nil
    ) ->   Request<String> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _registerOrderedSim(orderId: orderId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_registerOrderedSim()) is not sufficient):

        return req
    }
}