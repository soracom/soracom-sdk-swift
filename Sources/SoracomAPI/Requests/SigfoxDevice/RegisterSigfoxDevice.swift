extension Request {

    public class func registerSigfoxDevice(
        registrationRequest: SigfoxRegistrationRequest, 
        deviceId: String,
        responseHandler: ResponseHandler<SigfoxDevice>? = nil
    ) ->   Request<SigfoxDevice> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _registerSigfoxDevice(registrationRequest: registrationRequest, deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_registerSigfoxDevice()) is not sufficient):

        return req
    }
}