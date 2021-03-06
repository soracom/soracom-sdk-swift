//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Close SORACOM Gate.

        Close SORACOM Gate on the specified VPG.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/VirtualPrivateGateway/closeGate)
    */
    public class func closeGate(
        
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/virtual_private_gateways/\(vpgId)/gate/close"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
