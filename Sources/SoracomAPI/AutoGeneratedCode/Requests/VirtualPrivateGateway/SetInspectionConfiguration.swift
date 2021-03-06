//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Description forthcoming.

        Set configuration for Junction inspection feature

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/VirtualPrivateGateway/setInspectionConfiguration)
    */
    public class func setInspectionConfiguration(
        inspectionConfiguration: JunctionInspectionConfiguration, 
        vpgId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/virtual_private_gateways/\(vpgId)/junction/set_inspection"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = inspectionConfiguration.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
