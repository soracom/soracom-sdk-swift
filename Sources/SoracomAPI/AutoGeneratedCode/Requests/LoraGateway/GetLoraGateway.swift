//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == LoraGateway {

    /**
        Get LoRa gateway.

        Returns information about the specified LoRa gateway.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/LoraGateway/getLoraGateway)
    */
    public class func getLoraGateway(
        
        gatewayId: String,
        responseHandler: ResponseHandler<LoraGateway>? = nil
    ) ->   Request<LoraGateway> {

        let path  = "/lora_gateways/\(gatewayId)"

        let requestObject = Request<LoraGateway>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
