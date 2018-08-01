//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getExportedFile(
        
        exportedFileId: String,
        responseHandler: ResponseHandler<GetExportedFileResponse>? = nil
    ) ->   Request<GetExportedFileResponse> {

        let path = "/files/exported/{exported_file_id}".replacingOccurrences(of: "{" + "exportedFileId" + "}", with: "\(exportedFileId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<GetExportedFileResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
