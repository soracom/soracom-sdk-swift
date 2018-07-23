import SoracomAPI
import Foundation

Keychain.storageIdentifier = "CommandLineDemoForSoracomSDK-38039529-030E-4B12-8D34-33E787BB2783"
  // Keychain requires each app to use a unique identifier — any unique string is OK

Keychain.useInsecurePlaintextStorageAlways = true
  // In this demo application, we choose to use "insecure plain text" mode for the stored credentials, for simplicity, since Keychain doesn't currently support secure persistent storage on Linux. (The only credentials stored will be for the dummy user created in the API Sandbox environment.)

CLIDemo().run()
