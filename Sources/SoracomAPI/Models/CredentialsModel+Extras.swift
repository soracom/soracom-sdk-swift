// CredentialsModel.swift Created by Mason Mark on 2018-07-25. Copyright © 2018 Soracom, Inc. All rights reserved.

import Foundation

/// This structure is the full credential object that is returned by the API server upon a successful `listCredentials()` or `createCredential()` request.
///
/// **NOTE:** `CredentialsModel` objects returned by the API server contain a `CredentialsModel` structure, but that structure does not include the `secretAccessKey` value.

extension CredentialsModel {
    
    /// A convenience initializer mainly for automated tests.
    
    convenience init(description: String) {
        self.init()
        self.description = description
    }
}
