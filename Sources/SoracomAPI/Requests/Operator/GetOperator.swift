extension Request {

    public class func getOperator(
        
        operatorId: String,
        responseHandler: ResponseHandler<GetOperatorResponse>? = nil
    ) ->   Request<GetOperatorResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getOperator(operatorId: operatorId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getOperator()) is not sufficient):

        return req
    }
}