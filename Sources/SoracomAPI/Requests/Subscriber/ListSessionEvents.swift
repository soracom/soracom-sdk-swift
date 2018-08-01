extension Request {

    public class func listSessionEvents(
        
        imsi: String,
        from: Int? = nil,
        to: Int? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[SessionEvent]>? = nil
    ) ->   Request<[SessionEvent]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listSessionEvents(imsi: imsi, from: from, to: to, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listSessionEvents()) is not sufficient):

        return req
    }
}