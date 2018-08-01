extension Request {

    public class func getPaymentTransaction(
        
        paymentTransactionId: String,
        responseHandler: ResponseHandler<GetPaymentTransactionResult>? = nil
    ) ->   Request<GetPaymentTransactionResult> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getPaymentTransaction(paymentTransactionId: paymentTransactionId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getPaymentTransaction()) is not sufficient):

        return req
    }
}