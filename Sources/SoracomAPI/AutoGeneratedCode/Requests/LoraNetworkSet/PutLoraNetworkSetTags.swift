//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == LoraNetworkSet {

    /**
        Bulk Insert or Update LoRa network set tags.

        Inserts/updates tags for the specified LoRa network set.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/LoraNetworkSet/putLoraNetworkSetTags)
    */
    public class func putLoraNetworkSetTags(
        tags: [TagUpdateRequest], 
        nsId: String,
        responseHandler: ResponseHandler<LoraNetworkSet>? = nil
    ) ->   Request<LoraNetworkSet> {

        let path  = "/lora_network_sets/\(nsId)/tags"

        let requestObject = Request<LoraNetworkSet>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = tags.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
