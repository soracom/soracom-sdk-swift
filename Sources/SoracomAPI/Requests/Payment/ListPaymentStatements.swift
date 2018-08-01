extension Request {

    public class func listPaymentStatements(
        
        responseHandler: ResponseHandler<ListPaymentStatementResponse>? = nil
    ) ->   Request<ListPaymentStatementResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listPaymentStatements( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listPaymentStatements()) is not sufficient):

        return req
    }
}