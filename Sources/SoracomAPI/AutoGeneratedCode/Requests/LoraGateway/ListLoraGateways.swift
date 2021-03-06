//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == [LoraGateway] {

    /**
        List LoRa Gateways.

        Returns a list of LoRa gateways that match certain criteria. If the total number of LoRa gateways does not fit in one page, a URL for accessing the next page is returned in the 'Link' header of the response.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/LoraGateway/listLoraGateways)
    */
    public class func listLoraGateways(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[LoraGateway]>? = nil
    ) ->   Request<[LoraGateway]> {

        let path  = "/lora_gateways"

        let requestObject = Request<[LoraGateway]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "tagName": tagName,
            "tagValue": tagValue,
            "tagValueMatchMode": tagValueMatchMode,
            "limit": limit,
            "lastEvaluatedKey": lastEvaluatedKey
        ])

        return requestObject
    }

}
