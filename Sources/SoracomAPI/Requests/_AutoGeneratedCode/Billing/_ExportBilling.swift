//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _exportBilling(
        
        yyyyMM: String,
        exportMode: ExportMode? = nil,
        responseHandler: ResponseHandler<FileExportResponse>? = nil
    ) ->   Request<FileExportResponse> {

        let path  = "/bills/\(yyyyMM)/export"

        let requestObject = Request<FileExportResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post

        requestObject.query = makeQueryDictionary([
            "exportMode": exportMode
        ])

        return requestObject
    }

}
