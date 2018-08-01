extension Request {

    public class func listShippingAddresses(
        
        operatorId: String,
        responseHandler: ResponseHandler<ListShippingAddressResponse>? = nil
    ) ->   Request<ListShippingAddressResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listShippingAddresses(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listShippingAddresses()) is not sufficient):

        return req
    }
}