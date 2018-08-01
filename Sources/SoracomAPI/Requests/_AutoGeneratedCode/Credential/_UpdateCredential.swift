//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _updateCredential(
        credentials: CreateAndUpdateCredentialsModel, 
        credentialsId: String,
        responseHandler: ResponseHandler<CredentialsModel>? = nil
    ) ->   Request<CredentialsModel> {

        let path = "/credentials/{credentials_id}".replacingOccurrences(of: "{" + "credentialsId" + "}", with: "\(credentialsId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<CredentialsModel>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = credentials.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
