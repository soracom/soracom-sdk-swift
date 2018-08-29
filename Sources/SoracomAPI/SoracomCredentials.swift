// SoracomCredentials.swift Created by mason on 2016-02-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// Conveniences

extension SoracomCredentials {
    
    public init(authKeyId: String, authKeySecret: String) {
        self.init()
        self.authKeyID = authKeyId
        self.authKeySecret = authKeySecret
        self.type = .AuthKey
    }
}

/// Simple object to represent a set of Soracom credentials (either a Soracom root acccount, SAM user, AuthKey id/secret pair, or API Key / API Token pair). The first three types of credentials are used for authentication, while the last type is typically passed in HTTP headers to authorize individual API operations. `SoracomCredentials` can represent any/all of them, however, and can read/write to/from persistent storage (e.g., the system keychain on iOS and macOS).

public struct SoracomCredentials: Equatable, Codable {
    
    public var type           = SoracomCredentialType.RootAccount
    public var emailAddress   = ""
    public var operatorID     = ""
    public var username       = ""
    public var password       = ""
    public var authKeyID      = ""
    public var authKeySecret  = ""
    public var apiKey         = ""
    public var token          = ""
    
    
    /// The canonical initializer, allows setting any/all properties.
    
    public init(type: SoracomCredentialType = .RootAccount, emailAddress: String = "", operatorID: String = "", username: String = "", password: String = "", authKeyID: String = "", authKeySecret: String = "", apiKey: String = "", token: String = "") {
        self.type          = type
        self.emailAddress  = emailAddress
        self.operatorID    = operatorID
        self.username      = username
        self.password      = password
        self.authKeyID     = authKeyID
        self.authKeySecret = authKeySecret
        self.apiKey        = apiKey
        self.token         = token
    }
    
    
    /// Initialize a new credentials struct from a dictionary, which is (presumably) a dictionary generated with `dictionaryRepresentation()`.
    
    public init(withDictionary dictionary: Dictionary<String, String>) {
        
        if let typeName = dictionary[kType], let validType = SoracomCredentialType(rawValue: typeName) {
            self.type = validType
        }
        
        emailAddress  = dictionary[kEmailAddress] ?? ""
        operatorID    = dictionary[kOperatorId] ?? ""
        username      = dictionary[kUsername] ?? ""
        password      = dictionary[kPassword] ?? ""
        authKeyID     = dictionary[kAuthKeyID] ?? ""
        authKeySecret = dictionary[kAuthKeySecret] ?? ""
        apiKey        = dictionary[kAPIKey] ?? ""
        token         = dictionary[kToken] ?? ""
        
        checkForObsoleteFormat(dictionary)
    }
    
    
    /// Support initializing from obsolete formats from previous versions of this SDK.
    
    mutating func checkForObsoleteFormat(_ dictionary: Dictionary<String, String>) {
        let format = dictionary[kAccountCredentialsStorageFormatVersion] ?? "0"
        
        guard let version = Int(format) else {
            return
        }
        
        if version < 3 {
            
            if token == "" {
                if let token = dictionary["apiToken"] {
                    self.token = token
                }
            }
        }
    }
    
    
    /// Initialize from data in JSON format (e.g., that produced by `toJSON()`).
    
    public init(jsonData: Data) {
        
        let decoder = JSONDecoder()

        guard let dict = try? decoder.decode([String:String].self, from: jsonData) else {

            print("Note: SoracomCredentials init(jsonData:) failed.")
              // Could happen, e.g. if user edited data in Keychain
            
            self.init()
              // This initializer isn't failable, for historical reasons
            
            return
        }
        self.init(withDictionary: dict)
    }
    
    
    /// Initialize a credentials struct from the data stored in secure persistent storage (system keychain) with the given `identifier`. A `nil` value for `identifier` means the default identifier should be used (`SoracomCredentials.defaultStorageIdentifier`).
    ///
    /// The `namespace` parameter can typically be omitted.
    
    public init(withStorageIdentifier identifier: String?, namespace: UUID? = nil) {
        
        let base       = identifier ?? SoracomCredentials.defaultStorageIdentifier
        let identifier = SoracomCredentials.buildNamespacedIdentifier( base, namespace: namespace )
        
        if let data = Keychain.read(identifier) {
            self.init(jsonData: data)
        } else {
            self.init()
        }
    }
    
    
    /// Convenience method to return the default saved credentials. Returns a blank credentials struct if nothing is stored under the default identifier. If a non-nil value for `namespace` is not provided, the default namespace is used.
    
    public static func defaultSavedCredentials(namespace: UUID? = nil) -> SoracomCredentials {
        return self.init(withStorageIdentifier: nil, namespace: namespace)
    }
    
    
    /// Write the credentials to secure persistent storage (system keychain). If `identifier` is `nil`, then the default storage identifier is used. Any credentials that were previously stored with the same `identifier` are overwritten. This means that you can choose not to provide an identifier if you only need to store a single set of credentials per storage namespace (and a simple app might use only the default storage namespace).
    ///
    /// The `namespace` parameter can typically be omitted.
        
    public func save(_ identifier: String? = nil, namespace: UUID? = nil) -> Bool {
                
        let base       = identifier ?? SoracomCredentials.defaultStorageIdentifier
        let identifier = SoracomCredentials.buildNamespacedIdentifier(base, namespace: namespace)
        let data       = toJSONData()
        let result     = Keychain.write(identifier, data: data)
        
        return result
    }
    
    
    /// Delete the credential stored under `identifier` in `namespace`. If `namespace` is `nil`, the default namespace is used. Returns `true` on success, `false` otherwise (including if no such stored credential exists).
    
    public static func delete(identifier: String, namespace: UUID? = nil) -> Bool {
        
        let identifier = SoracomCredentials.buildNamespacedIdentifier(identifier, namespace: namespace)
        let result     = Keychain.delete(identifier)
        
        return result
    }

    
    /// Serialize the receiver to a dictionary. (You can use `init(withDictionary:)` to deserialize.)
    
    func dictionaryRepresentation() -> [String:String] {
        return [
            kType          : type.rawValue,
            kEmailAddress  : emailAddress,
            kOperatorId    : operatorID,
            kUsername      : username,
            kPassword      : password,
            kAuthKeyID     : authKeyID,
            kAuthKeySecret : authKeySecret,
            kAPIKey        : apiKey,
            kToken         : token,
            
            kAccountCredentialsStorageFormatVersion: "3"
        ]
        
        // FIXME: are we using "toDictionary()" or "dictionaryRepresentation()"?? Make it consistent, please.
    }
    
    
    /// Returns an NSData instance, which contains the receiver's contents as JSON.
    
    func toJSONData() -> Data {
        
        do {
            let dict = dictionaryRepresentation()
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            return jsonData
        } catch {
            fatalError("should be impossible: JSON serialization of credentials failed: \(error)")
        }
    }

    
    /// Returns true if all of the receiver's string properties are the empty string.
    
    public var blank: Bool {
        let other = SoracomCredentials(type: self.type)
        return self == other
    }
    
    
    /// The storage identifier used to look up the "default" credentials. When reading/writing credentials, if you don't specify an identifier, this will be used.
    
    static let defaultStorageIdentifier = "SoracomCredentials.Default"
    
    
    /// The default storage namespace is a UUID that uniquely identifies a type of storage within the scope of a client application. An app might use different namespaces because it offers a "test mode" that performs work in the API Sandbox instead of using a real production account. Another reason might be to read/write credentials from/to a separate namespace when running automated tests.

    /// In a more complex case, such as an app that interacts with multiple Soracom accounts, the credentials pertaining to each account could be maintained separately by using a unique namespace for each account.    

    static var defaultStorageNamespace: UUID = UUID(uuidString: "00000000-0000-0000-0000-DEFDEFDEFDEF")!

    
    /// Get a fully-qualified storage identifier based on `identifier`. If `namespace` is not supplied, the default storage namespace is used, which suffices for most purposes.
    
    static func buildNamespacedIdentifier(_ identifier: String, namespace: UUID? = nil) ->  String {
        
        let namespaceString = (namespace ?? defaultStorageNamespace).uuidString

        return "\(namespaceString).\(identifier)"
    }
    
}


// MARK: - Equatable conformance

public func ==(lhs: SoracomCredentials, rhs: SoracomCredentials) -> Bool
{
    return (lhs.type    == rhs.type) &&
    (lhs.emailAddress   == rhs.emailAddress) &&
    (lhs.operatorID     == rhs.operatorID) &&
    (lhs.username       == rhs.username) &&
    (lhs.password       == rhs.password) &&
    (lhs.authKeyID      == rhs.authKeyID) &&
    (lhs.authKeySecret  == rhs.authKeySecret) &&
    (lhs.apiKey         == rhs.apiKey) &&
    (lhs.token          == rhs.token   )
}


// MARK: - SoracomCredentialType

/// Defines the different types of authentication (see the [API Documentation](https://dev.soracom.io/jp/docs/api/#!/Auth/auth) for details).

public enum SoracomCredentialType: String, Codable {
    
    case RootAccount
    case SAM
    case AuthKey
    case KeyAndToken
}


// MARK: - Private constants (dictionary serialization keys)

private let kType          = "type"
private let kEmailAddress  = "emailAddress"
private let kOperatorId    = "operatorID"
private let kUsername      = "username"
private let kPassword      = "password"
private let kAuthKeyID     = "authKeyID"
private let kAuthKeySecret = "authKeySecret"
private let kAPIKey        = "apiKey"
private let kToken         = "token"

private let kAccountCredentialsStorageFormatVersion = "accountCredentialsStorageFormatVersion"
