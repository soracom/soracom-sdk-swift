extension Request {

    public class func deleteLoraGatewayTag(
        
        gatewayId: String,
        tagName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteLoraGatewayTag(gatewayId: gatewayId, tagName: tagName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteLoraGatewayTag()) is not sufficient):

        return req
    }
}