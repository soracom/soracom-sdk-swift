extension Request {

    public class func sendSms(
        smsForwardingRequest: SmsForwardingRequest, 
        imsi: String,
        responseHandler: ResponseHandler<SmsForwardingReport>? = nil
    ) ->   Request<SmsForwardingReport> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _sendSms(smsForwardingRequest: smsForwardingRequest, imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_sendSms()) is not sufficient):

        return req
    }
}