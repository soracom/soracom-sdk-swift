extension Request {

    public class func getBilling(
        
        yyyyMM: String,
        responseHandler: ResponseHandler<MonthlyBill>? = nil
    ) ->   Request<MonthlyBill> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getBilling(yyyyMM: yyyyMM,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getBilling()) is not sufficient):

        return req
    }
}