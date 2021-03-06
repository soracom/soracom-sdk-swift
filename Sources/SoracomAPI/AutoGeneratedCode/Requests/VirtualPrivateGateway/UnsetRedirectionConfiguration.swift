//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Description forthcoming.

        Unset configuration for Junction redirection feature

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/VirtualPrivateGateway/unsetRedirectionConfiguration)
    */
    public class func unsetRedirectionConfiguration(
        
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/virtual_private_gateways/\(vpgId)/junction/unset_redirection"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
