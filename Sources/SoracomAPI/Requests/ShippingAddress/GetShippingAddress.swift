extension Request {

    public class func getShippingAddress(
        
        operatorId: String,
        shippingAddressId: String,
        responseHandler: ResponseHandler<GetShippingAddressResponse>? = nil
    ) ->   Request<GetShippingAddressResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getShippingAddress(operatorId: operatorId, shippingAddressId: shippingAddressId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getShippingAddress()) is not sufficient):

        return req
    }
}