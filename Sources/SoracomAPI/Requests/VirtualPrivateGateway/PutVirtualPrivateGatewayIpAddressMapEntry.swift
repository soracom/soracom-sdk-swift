extension Request {

    public class func putVirtualPrivateGatewayIpAddressMapEntry(
        putIpAddressMapEntryRequest: PutIpAddressMapEntryRequest, 
        vpgId: String,
        responseHandler: ResponseHandler<IpAddressMapEntry>? = nil
    ) ->   Request<IpAddressMapEntry> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _putVirtualPrivateGatewayIpAddressMapEntry(putIpAddressMapEntryRequest: putIpAddressMapEntryRequest, vpgId: vpgId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_putVirtualPrivateGatewayIpAddressMapEntry()) is not sufficient):

        return req
    }
}