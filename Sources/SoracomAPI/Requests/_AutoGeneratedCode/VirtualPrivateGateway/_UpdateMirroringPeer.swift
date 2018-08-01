//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _updateMirroringPeer(
        updates: [AttributeUpdate], 
        vpgId: String,
        ipaddr: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path = "/virtual_private_gateways/{vpg_id}/junction/mirroring/peers/{ipaddr}".replacingOccurrences(of: "{" + "vpgId" + "}", with: "\(vpgId)").replacingOccurrences(of: "{" + "ipaddr" + "}", with: "\(ipaddr)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = updates.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
