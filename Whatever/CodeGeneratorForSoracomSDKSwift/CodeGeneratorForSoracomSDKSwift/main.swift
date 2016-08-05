// CodeGeneratorForSoracomSDKSwift Created by mason on 2016-08-05. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


let opts = ArgParser.parse(ProcessInfo.processInfo.arguments)
let swag = Swaggerer(options: opts)

swag.run()
