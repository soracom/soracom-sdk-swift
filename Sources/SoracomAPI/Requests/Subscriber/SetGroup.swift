extension Request {

    public class func setGroup(
        group: SetGroupRequest, 
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setGroup(group: group, imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setGroup()) is not sufficient):

        return req
    }
}