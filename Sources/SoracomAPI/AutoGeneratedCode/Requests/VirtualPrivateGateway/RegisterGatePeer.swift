//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == GatePeer {

    /**
        Register VPG Gate peer

        Register a host as a gate peer in the Virtual Private Gateway

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/VirtualPrivateGateway/registerGatePeer)
    */
    public class func registerGatePeer(
        gatePeer: RegisterGatePeerRequest, 
        vpgId: String,
        responseHandler: ResponseHandler<GatePeer>? = nil
    ) ->   Request<GatePeer> {

        let path  = "/virtual_private_gateways/\(vpgId)/gate/peers"

        let requestObject = Request<GatePeer>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = gatePeer.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
