//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Delete a credential.

        Deletes a credential.

        Docs: https://dev.soracom.io/en/docs/api/#!/Credential/deleteCredential
    */
    public class func _deleteCredential(
        
        credentialsId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/credentials/\(credentialsId)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete


        return requestObject
    }

}
