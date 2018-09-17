// Enums.swift Created by mason on 2018-07-31. 

// FIXME: these enums should be auto-generated, this is a stopgap hack for now

import Foundation

public enum ExportMode: String, Codable {
    case async = "async"
    case sync = "sync"
    
    public static let cases: [ExportMode] = [
        .async,
        .sync,
        ]
}

/** Namespace of target parameters. */
public enum Namespace: String, Codable {
    case soracomAir = "SoracomAir"
    case soracomBeam = "SoracomBeam"
    case soracomEndorse = "SoracomEndorse"
    case soracomFunnel = "SoracomFunnel"
    case soracomHarvest = "SoracomHarvest"
    case soracomKrypton = "SoracomKrypton"
    
    public static let cases: [Namespace] = [
        .soracomAir,
        .soracomBeam,
        .soracomEndorse,
        .soracomFunnel,
        .soracomHarvest,
        .soracomKrypton,
        ]
}

/** target */
public enum Target: String, Codable {
    case `operator` = "operator"
    case imsi = "imsi"
    case tag = "tag"
    case group = "group"
    
    public static let cases: [Target] = [
        .`operator`,
        .imsi,
        .tag,
        .group,
        ]
}

/** Sort order of the data entries. Either descending (latest data entry first) or ascending (oldest data entry first). */
public enum Sort: String, Codable {
    case desc = "desc"
    case asc = "asc"
    
    public static let cases: [Sort] = [
        .desc,
        .asc,
        ]
}

/** Type of resource. FIXME: we would like this to be auto-generated, but we have some naming conflicts with different kinds of usages that need to be worked out first */
public enum ResourceType: String, Codable {
    case device = "Device"
    case eventHandler = "EventHandler"
    case loraDevice = "LoraDevice"
    case sigfoxDevice = "SigfoxDevice"
    case subscriber = "Subscriber"
    case subscriberIdentityModule = "SubscriberIdentityModule"
    case virtualPrivateGateway = "VirtualPrivateGateway"

    public static let cases: [ResourceType] = [
        .device,
        .eventHandler,
        .loraDevice,
        .sigfoxDevice,
        .subscriber,
        .subscriberIdentityModule,
        .virtualPrivateGateway
        ]
}


public enum Service: String, Codable {
    case air = "Air"
    case beam = "Beam"
    case canal = "Canal"
    case direct = "Direct"
    case door = "Door"
    case endorse = "Endorse"
    case funnel = "Funnel"
    case gate = "Gate"
    
    public static let cases: [Service] = [
        .air,
        .beam,
        .canal,
        .direct,
        .door,
        .endorse,
        .funnel,
        .gate,
    ]
}


public enum Period: String, Codable {
    case month = "month"
    case day = "day"
    case minutes = "minutes"
    
    public static let cases: [Period] = [
        .month,
        .day,
        .minutes,
        ]
}


/** Type of the search ('AND searching' or 'OR searching') */
public enum SearchType: String, Codable {
    case and = "and"
    case or = "or"
    
    public static let cases: [SearchType] = [
        .and,
        .or,
        ]
}


public struct GroupId: Codable {
    var groupId: String
}

public struct Arg: Codable {
    var value: String
}

public struct Value: Codable {
    var value: String
}


