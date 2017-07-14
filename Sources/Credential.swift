// Credential.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// This structure is the full credential object that is returned by the API server upon a successful `listCredentials()` or `createCredential()` request.
///
/// **NOTE:** `Credential` objects returned by the API server contain a `Credential` structure, but that structure may not (always does not?) include the `secretAccessKey` value.

public struct Credential: PayloadConvertible, Codable {
    
    var createDateTime   : Int?
    var credentials      : Credentials?
    var credentialsId    : String?
    var description      : String?
    var lastUsedDateTime : Int?
    var type             : String?
    var updateDateTime   : Int?
}


extension Credential {
    
    /// A convenience initializer mainly for automated tests.
    
    init(description: String) {
        self.description = description
    }
}


//public struct CredentialList : Codable, PayloadConvertible {
//    
//    var credentials: [Credential] = []
//}
// Mason 2017-07-14: I think this style above can be useful, but only if the API returns
// something like {credentials: [{},{},...]}. Because in that kind of case, it makes using
// Codable's default behavior easy. But, for cases where the API returns an arry as the root
// object, then an implementation like this actually makes us fight against Codable's defaults
// and I think we are better off just using [Credential] type (that is, Swifts "array of 
// Credential" type).



/// This structure contains the values used to create or update a Credentials object.

public struct CredentialOptions: PayloadConvertible {
    
    static func from(_ payload: Payload?) -> CredentialOptions? {
        fatalError("Mason 2017-07-14 TEMPORARY FIX FOR BUILD (reorganizing protocols) FIXME")
    }
    
    
    var type: String
    var description: String
    var credentials: Credentials = Credentials()
    
    func toPayload() -> Payload {
        
        let result: Payload = [
            .type        : type,
            .description : description,
            .credentials : credentials.toPayload()
        ]
        return result
    }
}

/// This structure contains the raw credential values pertaining to a foreign service like AWS.

public struct Credentials: PayloadConvertible, Codable {
    
    var accessKeyId: String     = ""
    var secretAccessKey: String? = nil
    
    func toPayload() -> Payload {
        
        let result: Payload = [
            .accessKeyId     : accessKeyId,
            ]
        
        if let k = secretAccessKey {
            result[.secretAccessKey] = k
        }
        
        return result
    }
    
    public static func from(_ payload: Payload?) -> Credentials? {
        
        guard let payload = payload else {
            return nil
        }
        
        var result             = Credentials()
        result.accessKeyId     = payload[.accessKeyId]     as? String ?? ""
        result.secretAccessKey = payload[.secretAccessKey] as? String
        
        return result
    }
}


