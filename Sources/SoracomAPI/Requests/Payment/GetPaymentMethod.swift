extension Request {

    public class func getPaymentMethod(
        
        responseHandler: ResponseHandler<GetPaymentMethodResult>? = nil
    ) ->   Request<GetPaymentMethodResult> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getPaymentMethod( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getPaymentMethod()) is not sufficient):

        return req
    }
}