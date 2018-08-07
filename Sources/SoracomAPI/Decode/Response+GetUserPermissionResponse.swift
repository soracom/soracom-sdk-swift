// DO NOT EDIT; THIS CODE IS AUTOMATICALLY GENERATED AND WILL BE PERIODICALLY OVERWRITTEN.
// Generated on behalf of Kludge-O-Matic via swaggen

import Foundation

extension Response where T == GetUserPermissionResponse {

    public func parse() -> T? {

        guard let data = data else {
            return nil
        }

        return try? JSONDecoder().decode(GetUserPermissionResponse.self, from: data)
    }

}
