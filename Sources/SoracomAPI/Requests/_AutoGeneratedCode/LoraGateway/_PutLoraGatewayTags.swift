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

    let path = "/lora_gateways/{gateway_id}/tags".replacingOccurrences(of: "{" + "gateway_id" + "}", with: "\(gatewayId)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<LoraGateway>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = tags.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}