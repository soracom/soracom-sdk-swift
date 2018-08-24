//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == LoraGateway {

    /**
        Enable Termination of LoRa gateway.

        Enables termination of specified LoRa gateway.

        Docs: https://dev.soracom.io/en/docs/api/#!/LoraGateway/enableTerminationOnLoraGateway
    */
    public class func enableTerminationOnLoraGateway(
        
        gatewayId: String,
        responseHandler: ResponseHandler<LoraGateway>? = nil
    ) ->   Request<LoraGateway> {

        let path  = "/lora_gateways/\(gatewayId)/enable_termination"

        let requestObject = Request<LoraGateway>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}