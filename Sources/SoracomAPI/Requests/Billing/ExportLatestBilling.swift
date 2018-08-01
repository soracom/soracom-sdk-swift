extension Request {

    public class func exportLatestBilling(
        
        exportMode: ExportMode? = nil,
        responseHandler: ResponseHandler<FileExportResponse>? = nil
    ) ->   Request<FileExportResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _exportLatestBilling(exportMode: exportMode,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_exportLatestBilling()) is not sufficient):

        return req
    }
}