extension Request {

    public class func listVirtualPrivateGatewayIpAddressMapEntries(
        
        vpgId: String,
        responseHandler: ResponseHandler<[IpAddressMapEntry]>? = nil
    ) ->   Request<[IpAddressMapEntry]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listVirtualPrivateGatewayIpAddressMapEntries(vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listVirtualPrivateGatewayIpAddressMapEntries()) is not sufficient):

        return req
    }
}