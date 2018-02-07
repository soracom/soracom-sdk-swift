// BaseTestCase+FixtureData.swift Created by mason on 2017-07-28. 

import Foundation

struct Fixtures {
    
    struct Data {
        
        static var subscribers: Foundation.Data {
            let json = """
                [
                  {
                    "imsi": "448675309635677",
                    "msisdn": "818675309582",
                    "ipAddress": "10.176.129.76",
                    "operatorId": "OP8675309161",
                    "apn": "soracom.io",
                    "groupId": "deadbeef-9671-471f-a5ea-decafbadbad7",
                    "createdAt": 1453872836133,
                    "lastModifiedAt": 1501144207429,
                    "expiredAt": null,
                    "expiryAction": "deleteSession",
                    "terminationEnabled": false,
                    "status": "active",
                    "tags": {
                      "name": "test-sim-001"
                    },
                    "sessionStatus": {
                      "lastUpdatedAt": 1501144207429,
                      "imei": "355886753098142",
                      "location": null,
                      "ueIpAddress": "10.176.129.76",
                      "dnsServers": [
                        "100.127.0.53",
                        "100.127.1.53"
                      ],
                      "online": true,
                      "gatewayPublicIpAddress": "54.250.252.65"
                    },
                    "imeiLock": null,
                    "speedClass": "s1.fast",
                    "moduleType": "nano",
                    "plan": 1,
                    "iccid": "8986753093541663304",
                    "serialNumber": "DN0867530963300",
                  },
                  {
                    "imsi": "448675309635677",
                    "msisdn": "818675309582",
                    "ipAddress": "10.176.129.76",
                    "operatorId": "OP8675309161",
                    "apn": "soracom.io",
                    "groupId": "deadface-9671-471f-a5ea-decafbadbad7",
                    "createdAt": 1453872836133,
                    "lastModifiedAt": 1501144207429,
                    "expiredAt": null,
                    "expiryAction": "deleteSession",
                    "terminationEnabled": false,
                    "status": "active",
                    "tags": {
                      "name": "test-sim-002"
                    },
                    "sessionStatus": {
                      "lastUpdatedAt": 1501144207429,
                      "imei": "355886753098143",
                      "location": null,
                      "ueIpAddress": "10.176.129.76",
                      "dnsServers": [
                        "100.127.0.53",
                        "100.127.1.53"
                      ],
                      "online": true,
                      "gatewayPublicIpAddress": "54.250.252.65"
                    },
                    "imeiLock": null,
                    "speedClass": "s1.slow",
                    "moduleType": "nano",
                    "plan": 1,
                    "iccid": "8986753093541663305",
                    "serialNumber": "DN0867530963301",
                  }
                ]
            """
            
            return json.data(using: .utf8)!
        }

    }
}

