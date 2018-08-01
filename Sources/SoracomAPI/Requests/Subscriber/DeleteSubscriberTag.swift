extension Request {

    public class func deleteSubscriberTag(
        
        imsi: String,
        tagName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteSubscriberTag(imsi: imsi, tagName: tagName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteSubscriberTag()) is not sufficient):

        return req
    }
}