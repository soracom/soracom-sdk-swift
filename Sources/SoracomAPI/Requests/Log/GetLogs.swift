extension Request {

    public class func getLogs(
        
        resourceType: ResourceType? = nil,
        resourceId: String? = nil,
        service: Service? = nil,
        from: Int? = nil,
        to: Int? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[LogEntry]>? = nil
    ) ->   Request<[LogEntry]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getLogs(resourceType: resourceType, resourceId: resourceId, service: service, from: from, to: to, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getLogs()) is not sufficient):

        return req
    }
}