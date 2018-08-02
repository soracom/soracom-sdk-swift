//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _listVirtualPrivateGateways(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[VirtualPrivateGateway]>? = nil
    ) ->   Request<[VirtualPrivateGateway]> {

        let path = "/virtual_private_gateways" // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<[VirtualPrivateGateway]>.init(path, responseHandler: responseHandler)

        
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
