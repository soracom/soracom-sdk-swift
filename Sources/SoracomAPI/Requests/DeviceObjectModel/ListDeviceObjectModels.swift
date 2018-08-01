extension Request {

    public class func listDeviceObjectModels(
        
        lastEvaluatedKey: String? = nil,
        limit: Int? = nil,
        responseHandler: ResponseHandler<[DeviceObjectModel]>? = nil
    ) ->   Request<[DeviceObjectModel]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listDeviceObjectModels(lastEvaluatedKey: lastEvaluatedKey, limit: limit,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listDeviceObjectModels()) is not sufficient):

        return req
    }
}