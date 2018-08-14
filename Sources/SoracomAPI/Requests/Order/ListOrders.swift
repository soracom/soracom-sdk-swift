extension Request where T == ListOrderResponse {

    public class func listOrders(
        
        responseHandler: ResponseHandler<ListOrderResponse>? = nil
    ) ->   Request<ListOrderResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listOrders( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listOrders()) is not sufficient):

        return req
    }
}
