//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _deleteLoraGatewayTag(
        
        gatewayId: String,
        tagName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

    let path = "/lora_gateways/{gateway_id}/tags/{tag_name}".replacingOccurrences(of: "{" + "gateway_id" + "}", with: "\(gatewayId)").replacingOccurrences(of: "{" + "tag_name" + "}", with: "\(tagName)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete


        return requestObject
    }

}
