extension Request {

    public class func deleteVirtualPrivateGatewayIpAddressMapEntry(
        
        vpgId: String,
        key: String,
        responseHandler: ResponseHandler<IpAddressMapEntry>? = nil
    ) ->   Request<IpAddressMapEntry> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteVirtualPrivateGatewayIpAddressMapEntry(vpgId: vpgId, key: key,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteVirtualPrivateGatewayIpAddressMapEntry()) is not sufficient):

        return req
    }
}