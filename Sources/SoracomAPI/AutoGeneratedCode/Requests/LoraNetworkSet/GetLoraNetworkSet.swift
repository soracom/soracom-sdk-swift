//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == LoraNetworkSet {

    /**
        Get LoRa network set.

        Returns information about the specified LoRa network set.

        Docs: https://dev.soracom.io/en/docs/api/#!/LoraNetworkSet/getLoraNetworkSet
    */
    public class func getLoraNetworkSet(
        
        nsId: String,
        responseHandler: ResponseHandler<LoraNetworkSet>? = nil
    ) ->   Request<LoraNetworkSet> {

        let path  = "/lora_network_sets/\(nsId)"

        let requestObject = Request<LoraNetworkSet>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}