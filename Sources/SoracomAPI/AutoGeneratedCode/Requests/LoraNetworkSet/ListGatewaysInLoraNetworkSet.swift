//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == [LoraGateway] {

    /**
        List LoRa Gateways in a Network Set.

        Returns a list of LoRa gateways that belong to the specified network set. If the total number of LoRa gateways does not fit in one page, a URL for accessing the next page is returned in the 'Link' header of the response.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/LoraNetworkSet/listGatewaysInLoraNetworkSet)
    */
    public class func listGatewaysInLoraNetworkSet(
        
        nsId: String,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[LoraGateway]>? = nil
    ) ->   Request<[LoraGateway]> {

        let path  = "/lora_network_sets/\(nsId)/gateways"

        let requestObject = Request<[LoraGateway]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "limit": limit,
            "lastEvaluatedKey": lastEvaluatedKey
        ])

        return requestObject
    }

}
