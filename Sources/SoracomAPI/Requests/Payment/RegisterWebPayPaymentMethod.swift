extension Request where T == NoResponseBody {

    public class func registerWebPayPaymentMethod(
        creditCard: CreditCard, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _registerWebPayPaymentMethod(creditCard: creditCard,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_registerWebPayPaymentMethod()) is not sufficient):

        return req
    }
}
