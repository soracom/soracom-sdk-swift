//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == FileExportResponse {

    /**
        Export latest billing CSV file to S3.

        Returns detailed information of the billing amounts for the latest month. This detailed information includes billing amounts per day, subscriber, and billing item. The amounts retrieved using this API correspond to the values before the invoice was finalized.

        Docs: https://dev.soracom.io/en/docs/api/#!/Billing/exportLatestBilling
    */
    public class func exportLatestBilling(
        
        exportMode: ExportMode? = nil,
        responseHandler: ResponseHandler<FileExportResponse>? = nil
    ) ->   Request<FileExportResponse> {

        let path  = "/bills/latest/export"

        let requestObject = Request<FileExportResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post

        requestObject.query = makeQueryDictionary([
            "exportMode": exportMode
        ])

        return requestObject
    }

}