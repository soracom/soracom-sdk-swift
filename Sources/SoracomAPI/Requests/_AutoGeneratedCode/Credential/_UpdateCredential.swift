//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Update a credential.

        Updates a credential.

        Docs: https://dev.soracom.io/en/docs/api/#!/Credential/updateCredential
    */
    public class func _updateCredential(
        credentials: CreateAndUpdateCredentialsModel, 
        credentialsId: String,
        responseHandler: ResponseHandler<CredentialsModel>? = nil
    ) ->   Request<CredentialsModel> {

        let path  = "/credentials/\(credentialsId)"

        let requestObject = Request<CredentialsModel>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = credentials.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
