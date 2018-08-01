extension Request {

    public class func getOrder(
        
        orderId: String,
        responseHandler: ResponseHandler<GetOrderResponse>? = nil
    ) ->   Request<GetOrderResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getOrder(orderId: orderId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getOrder()) is not sufficient):

        return req
    }
}