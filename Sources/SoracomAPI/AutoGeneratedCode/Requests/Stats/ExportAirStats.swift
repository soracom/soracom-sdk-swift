//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == FileExportResponse {

    /**
        Export Air Usage Report of All Subscribers.

        Retrieves a file containing the usage report of all subscribers for the specified operator. The report data range is specified with from, to in unixtime. The report contains monthly data. The file output destination is AWS S3. The file output format is CSV.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Stats/exportAirStats)
    */
    public class func exportAirStats(
        request: ExportRequest, 
        operatorId: String,
        exportMode: ExportMode? = nil,
        responseHandler: ResponseHandler<FileExportResponse>? = nil
    ) ->   Request<FileExportResponse> {

        let path  = "/stats/air/operators/\(operatorId)/export"

        let requestObject = Request<FileExportResponse>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post

        requestObject.query = makeQueryDictionary([
            "exportMode": exportMode
        ])

        return requestObject
    }

}
