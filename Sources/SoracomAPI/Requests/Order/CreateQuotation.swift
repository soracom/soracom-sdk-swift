extension Request {

    public class func createQuotation(
        request: CreateEstimatedOrderRequest, 
        responseHandler: ResponseHandler<EstimatedOrderModel>? = nil
    ) ->   Request<EstimatedOrderModel> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _createQuotation(request: request,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_createQuotation()) is not sufficient):

        return req
    }
}