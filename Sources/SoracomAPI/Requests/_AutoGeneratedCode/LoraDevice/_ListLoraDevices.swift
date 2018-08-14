//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        List LoRa devices.

        Returns a list of LoRa devices that match certain criteria. If the total number of LoRa devices does not fit in one page, a URL for accessing the next page is returned in the 'Link' header of the response.

        Docs: https://dev.soracom.io/en/docs/api/#!/LoraDevice/listLoraDevices
    */
    public class func _listLoraDevices(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[LoraDevice]>? = nil
    ) ->   Request<[LoraDevice]> {

        let path  = "/lora_devices"

        let requestObject = Request<[LoraDevice]>.init(path, responseHandler: responseHandler)

        
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
