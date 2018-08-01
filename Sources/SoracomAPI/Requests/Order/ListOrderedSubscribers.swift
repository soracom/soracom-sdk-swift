extension Request {

    public class func listOrderedSubscribers(
        
        orderId: String,
        lastEvaluatedKey: String? = nil,
        limit: Int? = nil,
        responseHandler: ResponseHandler<ListOrderedSubscriberResponse>? = nil
    ) ->   Request<ListOrderedSubscriberResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listOrderedSubscribers(orderId: orderId, lastEvaluatedKey: lastEvaluatedKey, limit: limit,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listOrderedSubscribers()) is not sufficient):

        return req
    }
}