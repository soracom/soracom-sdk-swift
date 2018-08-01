extension Request {

    public class func putLoraGatewayTags(
        tags: [TagUpdateRequest], 
        gatewayId: String,
        responseHandler: ResponseHandler<LoraGateway>? = nil
    ) ->   Request<LoraGateway> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _putLoraGatewayTags(tags: tags, gatewayId: gatewayId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_putLoraGatewayTags()) is not sufficient):

        return req
    }
}