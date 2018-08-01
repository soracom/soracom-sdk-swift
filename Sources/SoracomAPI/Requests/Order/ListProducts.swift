extension Request {

    public class func listProducts(
        
        responseHandler: ResponseHandler<ListProductResponse>? = nil
    ) ->   Request<ListProductResponse> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listProducts( responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listProducts()) is not sufficient):

        return req
    }
}