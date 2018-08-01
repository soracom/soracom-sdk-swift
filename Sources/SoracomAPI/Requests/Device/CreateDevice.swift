extension Request {

    public class func createDevice(
        device: Device, 
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createDevice(device: device,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createDevice()) is not sufficient):

        return req
    }
}