//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _terminateVirtualPrivateGateway(
        
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path = "/virtual_private_gateways/{vpg_id}/terminate".replacingOccurrences(of: "{" + "vpgId" + "}", with: "\(vpgId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
