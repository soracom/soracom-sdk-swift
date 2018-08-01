extension Request {

    public class func createShippingAddress(
        model: ShippingAddressModel, 
        operatorId: String,
        responseHandler: ResponseHandler<String>? = nil
    ) ->   Request<String> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createShippingAddress(model: model, operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createShippingAddress()) is not sufficient):

        return req
    }
}