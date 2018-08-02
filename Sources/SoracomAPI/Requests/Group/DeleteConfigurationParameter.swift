import Foundation

extension Request where T == NoResponseBody {

    /// Delete parameters for the specified group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/deleteConfigurationParameter)
    ///
    /// Note that this method will handle percent-encoding the configuration parameter name, as mentioned in the API docs, so `parameterName` can just be the name of the parameter as-is.

    public class func deleteConfigurationParameter(
        
        groupId: String,
        namespace: Namespace,
        name: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let encodedName = name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? name;
        
        // Mason 2016-06-30: FIXME: We don't currently have a way to make a request fail with an error before it is run. I think we probably should, but it is beyond the scope of what I am currently working on. I want to think about it more. Subclass that overrides run(), wait() and any other future methods that execute the request? Or extend Request itself to have some kind pre-execute error property that run(), wait() etc respect? Or other? Deferring by marking FIXME here because we really don't want to be careless with parameters that control data getting deleted. For now, though, this kludge:

        // Call the auto-generated implmentation, created from the API spec:
        let req = _deleteConfigurationParameter(groupId: groupId, namespace: namespace, name: encodedName,  responseHandler: responseHandler)


        return req
    }
}
