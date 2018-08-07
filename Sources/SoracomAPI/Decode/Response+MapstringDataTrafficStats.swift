// DO NOT EDIT; THIS CODE IS AUTOMATICALLY GENERATED AND WILL BE PERIODICALLY OVERWRITTEN.
// Generated on behalf of Kludge-O-Matic via swaggen

import Foundation

extension Response where T == MapstringDataTrafficStats {

    public func parse() -> T? {

        guard let data = data else {
            return nil
        }

        return try? JSONDecoder().decode(MapstringDataTrafficStats.self, from: data)
    }

}
