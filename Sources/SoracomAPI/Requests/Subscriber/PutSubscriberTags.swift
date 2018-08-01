extension Request {

    public class func putSubscriberTags(
        tags: [TagUpdateRequest], 
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _putSubscriberTags(tags: tags, imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_putSubscriberTags()) is not sufficient):

        return req
    }
}