extension Request {

    public class func unsetDeviceGroup(
        
        deviceId: String,
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _unsetDeviceGroup(deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_unsetDeviceGroup()) is not sufficient):

        return req
    }
}