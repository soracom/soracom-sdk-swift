// Group.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// Description forthcoming.

public struct GroupConfiguration:  Codable {
    
    var SoracomAir: [String:String]?
    var SoracomBeam: [String:String]?
}

public struct Group:  Codable {
    
    // Mason 2016-06-30: So far what I have seen, the use cases for this structure only involve receiving it,
    // and not sending it. When we modify groups, we do so by sending a subset of information (tags or config).
    
    var configuration: GroupConfiguration? = nil
    var createdTime: Int? = nil
    var groupId: String? = ""
    var lastModifiedTime: Int? = nil
    var operatorId: String? = nil
    var tags: [String:String]? = nil
    
}

public typealias GroupList = [Group]
