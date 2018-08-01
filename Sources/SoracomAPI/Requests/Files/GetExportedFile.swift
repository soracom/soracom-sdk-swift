extension Request {

    public class func getExportedFile(
        
        exportedFileId: String,
        responseHandler: ResponseHandler<GetExportedFileResponse>? = nil
    ) ->   Request<GetExportedFileResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getExportedFile(exportedFileId: exportedFileId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getExportedFile()) is not sufficient):

        return req
    }
}