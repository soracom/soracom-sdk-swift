
print("Hello, world!")

import SoracomSDKSwift

let req = SoracomSDKSwift.Request.auth()
let res = req.wait()
print(res)

print("Goodbye, world!")
