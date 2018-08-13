//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _listCredentials(
        
        responseHandler: ResponseHandler<[CredentialsModel]>? = nil
    ) ->   Request<[CredentialsModel]> {

        let path  = "/credentials"

        let requestObject = Request<[CredentialsModel]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
