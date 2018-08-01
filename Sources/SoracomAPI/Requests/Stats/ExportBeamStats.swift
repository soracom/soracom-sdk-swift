extension Request {

    public class func exportBeamStats(
        request: ExportRequest, 
        operatorId: String,
        exportMode: ExportMode? = nil,
        responseHandler: ResponseHandler<FileExportResponse>? = nil
    ) ->   Request<FileExportResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _exportBeamStats(request: request, operatorId: operatorId, exportMode: exportMode,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_exportBeamStats()) is not sufficient):

        return req
    }
}