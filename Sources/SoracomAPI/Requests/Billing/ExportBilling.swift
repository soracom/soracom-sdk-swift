extension Request where T == FileExportResponse {

    public class func exportBilling(
        
        yyyyMM: String,
        exportMode: ExportMode? = nil,
        responseHandler: ResponseHandler<FileExportResponse>? = nil
    ) ->   Request<FileExportResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _exportBilling(yyyyMM: yyyyMM, exportMode: exportMode,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_exportBilling()) is not sufficient):

        return req
    }
}
