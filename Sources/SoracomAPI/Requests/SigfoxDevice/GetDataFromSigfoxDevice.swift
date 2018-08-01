extension Request {

    public class func getDataFromSigfoxDevice(
        
        deviceId: String,
        from: Int? = nil,
        to: Int? = nil,
        sort: Sort? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[DataEntry]>? = nil
    ) ->   Request<[DataEntry]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getDataFromSigfoxDevice(deviceId: deviceId, from: from, to: to, sort: sort, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getDataFromSigfoxDevice()) is not sufficient):

        return req
    }
}