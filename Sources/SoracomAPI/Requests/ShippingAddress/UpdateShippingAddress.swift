extension Request {

    public class func updateShippingAddress(
        model: ShippingAddressModel, 
        operatorId: String,
        shippingAddressId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateShippingAddress(model: model, operatorId: operatorId, shippingAddressId: shippingAddressId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateShippingAddress()) is not sufficient):

        return req
    }
}