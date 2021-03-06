//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == LoraGateway {

    /**
        Set Network Set ID of LoRa gateway.

        Sets or overwrites network set ID for the specified LoRa gateway.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/LoraGateway/setLoraNetworkSet)
    */
    public class func setLoraNetworkSet(
        nsId: SetNetworkSetRequest, 
        gatewayId: String,
        responseHandler: ResponseHandler<LoraGateway>? = nil
    ) ->   Request<LoraGateway> {

        let path  = "/lora_gateways/\(gatewayId)/set_network_set"

        let requestObject = Request<LoraGateway>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = nsId.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
