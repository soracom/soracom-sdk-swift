//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Description forthcoming.

        Remove peer from the list of Junction mirroring peers

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/VirtualPrivateGateway/deleteMirroringPeer)
    */
    public class func deleteMirroringPeer(
        
        vpgId: String,
        ipaddr: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/virtual_private_gateways/\(vpgId)/junction/mirroring/peers/\(ipaddr)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete


        return requestObject
    }

}
