// SoracomCredentials.swift Created by mason on 2016-02-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// Simple object to represent a set of Soracom credentials (either a Soracom root acccount, SAM user, AuthKey id/secret pair, or API Key / API Token pair). The first three types of credentials are used for authentication, while the last type is typically passed in HTTP headers to authorize individual API operations. `SoracomCredentials` can represent any/all of them, however, and can read/write to/from secure persistent storage (e.g., the system keychain on iOS and OSX).

public struct SoracomCredentials: Equatable {
    
    var type           = SoracomCredentialType.RootAccount
    var emailAddress   = ""
    var operatorID     = ""
    var username       = ""
    var password       = ""
    var authKeyID      = ""
    var authKeySecret  = ""
    var apiKey         = ""
    var apiToken       = ""
    
    // FIXME: add this to stash the expire time of credentials (for KeyAndToken case):    var expirationDate
    
    
    /// The canonical initializer, allows setting any/all properties.
    
    init(type: SoracomCredentialType = .RootAccount, emailAddress: String = "", operatorID: String = "", username: String = "", password: String = "", authKeyID: String = "", authKeySecret: String = "", apiKey: String = "", apiToken: String = "") {
        self.type          = type
        self.emailAddress  = emailAddress
        self.operatorID    = operatorID
        self.username      = username
        self.password      = password
        self.authKeyID     = authKeyID
        self.authKeySecret = password
        self.apiKey        = apiKey
        self.apiToken      = apiToken
    }
    
    
    /// Initialize a new credentials struct from a dictionary, which is (presumably) a dictionary generated with `dictionaryRepresentation()`.
    
    init(withDictionary dictionary: Dictionary<String, String>) {
        
        if let typeName = dictionary[kType], validType = SoracomCredentialType(rawValue: typeName) {
            self.type = validType
        }
        
        emailAddress  = dictionary[kEmailAddress] ?? ""
        operatorID    = dictionary[kOperatorId] ?? ""
        username      = dictionary[kUsername] ?? ""
        password      = dictionary[kPassword] ?? ""
        authKeyID     = dictionary[kAuthKeyID] ?? ""
        authKeySecret = dictionary[kAuthKeySecret] ?? ""
        apiKey        = dictionary[kAPIKey] ?? ""
        apiToken      = dictionary[kAPIToken] ?? ""
    }
    
    
    /// Initialize a credentials struct from the data stored in secure persistent storage (system keychain) with the given `identifier`. A `nil` value for `identifier` means the default identifier should be used (`SoracomCredentials.keychainItemDefault`).
    ///
    /// Under normal circumstances, the `namespace` parameter should be nil (because `SoracomCredentials.defaultStorageNamespace` should have already been set).
    
    init(withStorageIdentifier identifier: String?, namespace: NSUUID? = nil) {
        
        let base       = identifier ?? SoracomCredentials.defaultStorageIdentifier
        let identifier = SoracomCredentials.buildNamespacedIdentifier( base, namespace: namespace )
        
        if let data = Keychain.read(identifier), let dict = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [String:String] {
            self.init(withDictionary: dict)
        } else {
            self.init()
        }
    }
    
    
    /// Initialize and return a new credentials instance based on the values (if any) stored in secure persistent storage, using the default storage identifier for `type`. If nothing is stored for that identifier, a new empty credentials instance will be returned.
    ///
    /// Under normal circumstances, the `namespace` parameter should be nil (because `SoracomCredentials.defaultStorageNamespace` should have already been set).

    init(withStoredType type: SoracomCredentialType, namespace: NSUUID? = nil) {
        self.init(withStorageIdentifier: type.defaultStorageIdentifier(), namespace: namespace)
    }
    
    
    /// Write the credentials to secure persistent storage (system keychain). If `identifier` is `nil`, then the default storage identifier for the credentials type is used. Any credentials that were previously stored with the same `identifier` are overwritten. This means that you can choose not to provide an identifier if you only need to store a maximimum of one credentials structure of each type (the default key is provided by `SoracomCredentialType`, and is unique per-type). Also, if `replaceDefault` is true (which it is by default), the credentials are also separately persisted using the identifier `SoracomCredentials.defaultStorageIdentifier`. This allows retrieval of the "default" credentials (the meaning of which is application-specific), regardless of type.
    ///
    /// This makes it easy by default to retrieve the last-saved credentials of each type, and also to retrieve the last-saved credentials regardless of type.
    ///
    /// Under normal circumstances, the `namespace` parameter should be nil (because `SoracomCredentials.defaultStorageNamespace` should have already been set).
    
    func writeToSecurePersistentStorage(identifier: String? = nil, namespace: NSUUID? = nil, replaceDefault : Bool = true) -> Bool {
        
        let base       = identifier ?? type.defaultStorageIdentifier()
        let identifier = self.dynamicType.buildNamespacedIdentifier(base, namespace: namespace)
        let data       = NSKeyedArchiver.archivedDataWithRootObject(dictionaryRepresentation())
        var result     = Keychain.write(identifier, data: data)
        
        if (replaceDefault) {
            let base       = self.dynamicType.defaultStorageIdentifier
            let identifier = self.dynamicType.buildNamespacedIdentifier(base, namespace: namespace)
            result         = result && Keychain.write(identifier, data: data)
        }
        
        if (self.dynamicType.buildNamespacedIdentifier("") == self.dynamicType.debugNamespaceString) {
            print("*** WARNING: Default debug namespace string was used to write credentials to persistent storage.")
            print("***")
            print("*** This is acceptable for initial experimentation, tests, debugging, etc.")
            print("***")
            print("*** However, the default debug namespace string should never be used in production, because")
            print("*** credentials may be overwritten without warning. See the documentation for")
            print("*** defaultStorageNamespace for details.")
        }
        
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
            kAPIToken      : apiToken,
            
            kAccountCredentialsStorageFormatVersion: "2"
        ]
    }
    
    
    /// Returns true if all of the receiver's string properties are the empty string.
    var blank: Bool {
        let other = SoracomCredentials(type: self.type)
        return self == other
    }
    
    
    /// The storage identifier used to look up the "default" credentials. This is similar to SoracomCredentialType.defaultStorageIdentifier(), except that it is used to store and retrieve the default credentials, whatever type they happen to be. (What "default" means is application-specific, and no assumptions are made in this SDK about how it is to be used.)
    
    static let defaultStorageIdentifier = "jp.soracom.soracom-sdk-swift.SoracomCredentials.Default"
    
    
    /// The default storage namespace is a UUID that uniquely identifies the storage for a client application. Each application that uses this SDK should initialize this property to a hardcoded, globally unique UUID value. 
    ///
    /// When writing credentials to secure persistent storage, the default storage namespace is used to create unique storage keys, preventing applications that use the default read/write methods from overwriting credentials stored by another application that also uses this SDK.
    ///
    /// If a default storage namespace is not provided, then the a UUID based on `debugNamespaceString` will be used. **WARNING**: You should *always* specify a default storage namespace in production; the debug namespace is only intended for initial experimentation and debugging.
    ///
    /// To creat a unique string on OS X, run the `uuidgen` command in the Terminal. This will create a string like "1087FC09-CF01-4E6E-AEEE-2F9EACB0A3C9".
    ///
    /// Such a unique string should be hardcoded into every client somewhere early in initialization, like this:
    ///
    ///     if let namespace = NSUUID(UUIDString: "1087FC09-CF01-4E6E-AEEE-2F9EACB0A3C9") {
    ///         SoracomCredentials.defaultStorageNamespace = namespace
    ///     } else {
    ///         fatalError("App needs a valid UUID for its default storage namespace.")
    ///     }

    static var defaultStorageNamespace: NSUUID? = nil

    
    /// **WARNING**: You should *always* specify a default storage namespace in production. For initial experimentation and debugging convenience, however, a UUID based on this constant will be used. This means other clients of this SDK may overwrite your stored credentials, however.
    
    static let debugNamespaceString = "DEADBEEF-DEAD-BEEF-DEAD-DECAFBADDEAD"
    
    
    /// Get a valid storage namespace.
    
    static func buildNamespacedIdentifier(identifier: String, namespace: NSUUID? = nil) ->  String {
        
        var result = identifier
        
        if let namespace = namespace {
            result += namespace.UUIDString
            
        } else if let namespace = self.defaultStorageNamespace {
            result += namespace.UUIDString
            
        } else {

            if let namespace = NSUUID(UUIDString: self.debugNamespaceString) {
                result += namespace.UUIDString
            } else {
                result += "error"
                fatalError("fatal error: unable to create storage namespace")
            }
        }
        return result
    }
    
}


// MARK: - Equatable conformance

public func ==(lhs: SoracomCredentials, rhs: SoracomCredentials) -> Bool
{
    return (lhs.type == rhs.type) &&
    (lhs.emailAddress == rhs.emailAddress) &&
    (lhs.operatorID == rhs.operatorID) &&
    (lhs.username == rhs.username) &&
    (lhs.password == rhs.password) &&
    (lhs.authKeyID == rhs.authKeyID) &&
    (lhs.authKeySecret == rhs.authKeySecret) &&
    (lhs.apiKey == rhs.apiKey) &&
    (lhs.apiToken == rhs.apiToken)
}


// MARK: - SoracomCredentialType enum

/// Defines the different types of authentication (see the [API Documentation](https://dev.soracom.io/jp/docs/api/#!/Auth/auth) for details).

enum SoracomCredentialType: String {
    
    case RootAccount
    case SAM
    case AuthKey
    case KeyAndToken
    
    
    /// Returns the default identifier used to store credentials data of a given type. If your client code only needs to store one (or fewer) set of credentials for each type, then you can choose to omit the identifier when using `writeToSecurePersistentStorage()` and the default identifier will be used.
    
    func defaultStorageIdentifier() -> String {
        switch self {
        default:
            return "jp.soracom.soracom-sdk-swift.SoracomCredentials.Default.\(self.rawValue)"
        }
    }
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
private let kAPIToken      = "apiToken"

private let kAccountCredentialsStorageFormatVersion = "accountCredentialsStorageFormatVersion"
