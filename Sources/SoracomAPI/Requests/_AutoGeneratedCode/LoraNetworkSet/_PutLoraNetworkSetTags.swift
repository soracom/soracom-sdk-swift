//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _putLoraNetworkSetTags(
        tags: [TagUpdateRequest], 
        nsId: String,
        responseHandler: ResponseHandler<LoraNetworkSet>? = nil
    ) ->   Request<LoraNetworkSet> {

        let path = "/lora_network_sets/{ns_id}/tags".replacingOccurrences(of: "{" + "nsId" + "}", with: "\(nsId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<LoraNetworkSet>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = tags.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
