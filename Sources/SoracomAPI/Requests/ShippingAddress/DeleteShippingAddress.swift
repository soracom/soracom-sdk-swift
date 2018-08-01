extension Request {

    public class func deleteShippingAddress(
        
        operatorId: String,
        shippingAddressId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteShippingAddress(operatorId: operatorId, shippingAddressId: shippingAddressId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteShippingAddress()) is not sufficient):

        return req
    }
}