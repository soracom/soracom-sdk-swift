extension Request {

    public class func getBillingPerDay(
        
        yyyyMM: String,
        responseHandler: ResponseHandler<DailyBillResponse>? = nil
    ) ->   Request<DailyBillResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getBillingPerDay(yyyyMM: yyyyMM,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getBillingPerDay()) is not sufficient):

        return req
    }
}