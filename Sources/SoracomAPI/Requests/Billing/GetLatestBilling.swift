extension Request {

    public class func getLatestBilling(
        
        responseHandler: ResponseHandler<GetLatestBill>? = nil
    ) ->   Request<GetLatestBill> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getLatestBilling( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getLatestBilling()) is not sufficient):

        return req
    }
}