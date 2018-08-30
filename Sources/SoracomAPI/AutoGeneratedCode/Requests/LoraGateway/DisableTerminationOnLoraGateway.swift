//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == LoraGateway {

    /**
        Disable Termination of LoRa gateway.

        Disables termination of specified LoRa gateway.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/LoraGateway/disableTerminationOnLoraGateway)
    */
    public class func disableTerminationOnLoraGateway(
        
        gatewayId: String,
        responseHandler: ResponseHandler<LoraGateway>? = nil
    ) ->   Request<LoraGateway> {

        let path  = "/lora_gateways/\(gatewayId)/disable_termination"

        let requestObject = Request<LoraGateway>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
