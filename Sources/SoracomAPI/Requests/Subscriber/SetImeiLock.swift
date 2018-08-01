extension Request {

    public class func setImeiLock(
        imeiLock: SetImeiLockRequest, 
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setImeiLock(imeiLock: imeiLock, imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setImeiLock()) is not sufficient):

        return req
    }
}