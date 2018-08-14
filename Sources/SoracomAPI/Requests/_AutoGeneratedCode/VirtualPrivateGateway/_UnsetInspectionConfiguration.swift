//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Description forthcoming.

        Unset configuration for Junction inspection feature

        Docs: https://dev.soracom.io/en/docs/api/#!/VirtualPrivateGateway/unsetInspectionConfiguration
    */
    public class func _unsetInspectionConfiguration(
        
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/virtual_private_gateways/\(vpgId)/junction/unset_inspection"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
