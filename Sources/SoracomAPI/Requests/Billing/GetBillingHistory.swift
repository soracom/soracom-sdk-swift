extension Request {

    public class func getBillingHistory(
        
        responseHandler: ResponseHandler<GetBillingHistoryResponse>? = nil
    ) ->   Request<GetBillingHistoryResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getBillingHistory( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getBillingHistory()) is not sufficient):

        return req
    }
}