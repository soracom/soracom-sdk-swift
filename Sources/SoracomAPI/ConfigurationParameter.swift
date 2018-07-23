// ConfigurationParameter.swift Created by mason on 2017-07-26. 

public struct ConfigurationParameter:  Codable {
    
    public var key: String
    public var value: String
}


public typealias ConfigurationParameterList = [ConfigurationParameter]


/// These namespaces are used to get/set configurations (lists of keys and values) pertaining to different Soracom services.

public enum ConfigurationParametersNamespace: String {
    case SoracomAir
    case SoracomBeam
}
