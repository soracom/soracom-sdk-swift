//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _putLoraGatewayTags(
        tags: [TagUpdateRequest], 
        gatewayId: String,
        responseHandler: ResponseHandler<LoraGateway>? = nil
    ) ->   Request<LoraGateway> {

        let path = "/lora_gateways/{gateway_id}/tags".replacingOccurrences(of: "{" + "gatewayId" + "}", with: "\(gatewayId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<LoraGateway>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = tags.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
