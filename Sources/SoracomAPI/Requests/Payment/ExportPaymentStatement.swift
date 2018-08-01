extension Request {

    public class func exportPaymentStatement(
        
        paymentStatementId: String,
        exportMode: ExportMode? = nil,
        responseHandler: ResponseHandler<FileExportResponse>? = nil
    ) ->   Request<FileExportResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _exportPaymentStatement(paymentStatementId: paymentStatementId, exportMode: exportMode,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_exportPaymentStatement()) is not sufficient):

        return req
    }
}