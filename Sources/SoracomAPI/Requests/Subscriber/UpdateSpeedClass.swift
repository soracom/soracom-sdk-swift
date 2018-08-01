extension Request {

    public class func updateSpeedClass(
        speedClass: UpdateSpeedClassRequest, 
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _updateSpeedClass(speedClass: speedClass, imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_updateSpeedClass()) is not sufficient):

        return req
    }
}