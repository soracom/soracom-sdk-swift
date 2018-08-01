//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _deleteCredential(
        
        credentialsId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path = "/credentials/{credentials_id}".replacingOccurrences(of: "{" + "credentialsId" + "}", with: "\(credentialsId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete


        return requestObject
    }

}
