//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Get Virtual Private Gateway.

        Retrieves information about the specified VPG.

        Docs: https://dev.soracom.io/en/docs/api/#!/VirtualPrivateGateway/getVirtualPrivateGateway
    */
    public class func getVirtualPrivateGateway(
        
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/virtual_private_gateways/\(vpgId)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}