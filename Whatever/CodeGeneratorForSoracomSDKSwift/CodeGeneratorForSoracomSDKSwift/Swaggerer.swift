// Swaggerer.swift Created by mason on 2016-08-05. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

class Swaggerer {
    
    let options: [String:String]
    
    var pathToSwaggerCodegen = "/usr/local/bin/swagger-codegen" // could be option someday
    
    
    init(options: [String:String] = [:]) {
        self.options = options
    }
    
    
    var workingDirectory: String {
        
        return path(identifier: kWorkingDirectory) {
            FileManager().currentDirectoryPath
        }
    }
    
    
    var inputFile: String {
        
        return path(identifier: kInputFile) {
            "/Users/mason/Code/ios-client/Dependencies/soracom-sdk-swift/Whatever/CodeGeneratorForSoracomSDKSwift/soracom-api.en.json" // hehe
        }
    }
    
    
    var intermediateDirectory: String {
        
        return path(identifier: kWorkingDirectory) {
            (NSTemporaryDirectory() as NSString).appendingPathComponent("swaggerer-\(UUID().uuidString)")
        }
    }
    
    
    var outputDirectory: String {
        
        return path(identifier: kOutputDirectory) {
            (self.workingDirectory as NSString).appendingPathComponent("generated-source-code")
        }
    }
    
    
    var swaggererVersion: String {
        return "0.0d1"
    }
    
    
    func path(identifier: String, builder: ()->String) -> String {
        
        if let existing = options[identifier] {
            return existing
        } else if let existing = defaultDirectories[identifier] {
            return existing
        } else {
            let built = builder()
            defaultDirectories[identifier] = built
            return built
        }
    }
    
    
    private var defaultDirectories: [String:String] = [:]
    
    
    func run() {
        
        Swift.print("")
        print("SWAGGERER \(swaggererVersion) is running with these options:")
        print("")
        print("\(kWorkingDirectory): \(workingDirectory)")
        print("")
        print("\(kInputFile): \(inputFile)")
        print("")
        print("\(kIntermediateDirectory): \(intermediateDirectory)")
        print("")
        print("\(kOutputDirectory): \(outputDirectory)")
        print("")
        
        if swagger() {
            print("Code generation completed successfully.")
        } else {
            print("Code generation failed.")
        }
        
        print("")
        print("以上")
    }
    
    
    func swagger() -> Bool {
        
        guard swaggerIsAccessible() else {
            print("ERROR: The swagger-codegen command is not accessible.")
            print("You may need to run: brew install swagger-codegen")
            return false;
        }
        
        guard runSwaggerCommand() else {
            print("ERROR: The swagger-codegen command reported an error.")
            print("The output above may have clues pertaining to how this can be solved.")
            return false;
        }
        
        guard postProcessGeneratedCode() else {
            print("ERROR: The post-processing phase failed.")
            return false;
        }
        
        return true
    }
    
    
    func swaggerIsAccessible() -> Bool {
        return FileManager().isExecutableFile(atPath: pathToSwaggerCodegen)
    }
    
    
    func runSwaggerCommand() -> Bool {
        // swagger-codegen generate -i api-definition/soracom-api.en.json -l swift -o test-bro -t swagger-templates
        
        let templatesDir = "/Users/mason/Code/ios-client/Dependencies/soracom-sdk-swift/Whatever/CodeGeneratorForSoracomSDKSwift/swagger-templates-for-soracom-sdk-swift" // temporary, obviously...

        let swag = TaskWrapper(pathToSwaggerCodegen, arguments: ["generate", "-i", inputFile, "-l", "swift", "-o", intermediateDirectory, "-t", templatesDir])

        swag.launch()
        
        
        guard swag.terminationStatus == 0 else {
            print("ERROR: swagger-codegen got an error: \(swag.terminationStatus)")
            print("Here is some output that might help debug the issue:")
            print("stderr:")
            print(swag.stderrText)
            print("stdout:")
            print(swag.stdoutText)
            
            return false
        }
        return true
    }
    
    
    func postProcessGeneratedCode() -> Bool {
        
        guard let e = FileManager().enumerator(atPath: intermediateDirectory) else {
            print("Failed to enumerate contents of directory: \(intermediateDirectory)" )
            return false
        }
        
        // FIXME: We need to iterate through the list, and copy only what we want to outputDirectory.
        // I am not yet sure what we want (that's waiting on the custom code templates), so for now
        // I just take the path of least resistance and copy none of it. That means the output dir is
        // currently always empty. :-.
        /*
         >>> • .gitignore
         >>> • Cartfile
         >>> • CodeGeneratorForSoracomSDKSwift
         >>> • CodeGeneratorForSoracomSDKSwift.swiftmodule
         >>> • CodeGeneratorForSoracomSDKSwift.swiftmodule/x86_64.swiftdoc
         >>> • CodeGeneratorForSoracomSDKSwift.swiftmodule/x86_64.swiftmodule
         >>> • git_push.sh
         >>> • SwaggerClient
         >>> • SwaggerClient/Classes
         >>> • SwaggerClient/Classes/Swaggers
         >>> • SwaggerClient/Classes/Swaggers/AlamofireImplementations.swift
         >>> • SwaggerClient/Classes/Swaggers/APIHelper.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs
         >>> • SwaggerClient/Classes/Swaggers/APIs/AuthAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/BillingAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/CredentialAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/EventHandlerAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/GroupAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/OperatorAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/OrderAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/PaymentAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/RoleAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/ShippingAddressAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/StatsAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/SubscriberAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/UserAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs/VirtualPrivateGatewayAPI.swift
         >>> • SwaggerClient/Classes/Swaggers/APIs.swift
         >>> • SwaggerClient/Classes/Swaggers/Extensions.swift
         >>> • SwaggerClient/Classes/Swaggers/Models
         >>> • SwaggerClient/Classes/Swaggers/Models/ActionConfig.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ActionConfigProperty.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/AirStatsResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/APICallError.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/APICallErrorMessage.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/APIKeyResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/AttachRoleRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/AuthKeyResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/AuthRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/AuthResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/BeamStatsResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/Config.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CouponResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreateAndUpdateCredentialsModel.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreateEstimatedOrderRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreateEventHandlerRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreateGroupRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreateOrUpdateRoleRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreateRoleResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreateUserPasswordRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreateUserRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreateVirtualPrivateGatewayRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreateVpcPeeringConnectionRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CredentialsModel.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/CreditCard.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/DailyBill.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/DailyBillResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/DataTrafficStats.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/Error.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/EstimatedOrderItemModel.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/EstimatedOrderModel.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/EventHandlerModel.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ExpiryTime.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ExportRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/FileOutputResult.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GatePeer.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GenerateOperatorsAuthKeyResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GenerateTokenRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GenerateTokenResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GenerateUserAuthKeyResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GetBillingHistoryResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GetLatestBill.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GetOperatorResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GetOrderResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GetPaymentMethodResult.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GetPaymentTransactionResult.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GetShippingAddressResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GetUserPasswordResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GetUserPermissionResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/Group.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/GroupConfigurationUpdateRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/IpAddressMapEntry.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/IssueEmailChangeTokenRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/IssuePasswordResetTokenRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/IssueSubscriberTransferTokenRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/IssueSubscriberTransferTokenResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ListCouponResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ListOrderedSubscriberResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ListOrderResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ListProductResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ListRolesResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ListShippingAddressResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ListSubOperatorsResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/Map.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/MapstringDataTrafficStats.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/Mapstringstring.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/MonthlyBill.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/OrderedSubscriber.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/OrderItemModel.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/PaymentAmount.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/PaymentDescription.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ProductModel.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/PutIpAddressMapEntryRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/RegisterGatePeerRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/RegisterOperatorsRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/RegisterSubscribersRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/RoleResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/RuleConfig.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/RuleConfigProperty.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/SessionEvent.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/SessionStatus.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/SetUserPermissionRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ShippingAddressModel.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/ShippingCostModel.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/SoracomBeamStats.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/Subscriber.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/SupportTokenResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/Tag.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/TagUpdateRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/UpdateEventHandlerRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/UpdatePasswordRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/UpdateSpeedClassRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/UpdateUserRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/UserDetailResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/VerifyEmailChangeTokenRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/VerifyOperatorsRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/VerifyPasswordResetTokenRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/VerifySubscriberTransferTokenRequest.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/VerifySubscriberTransferTokenResponse.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/VirtualPrivateGateway.swift
         >>> • SwaggerClient/Classes/Swaggers/Models/VpcPeeringConnection.swift
         >>> • SwaggerClient/Classes/Swaggers/Models.swift
         >>> • SwaggerClient.podspec
         */
        
        for subpath in e {
            
            print("• \(subpath)")
        }
        
        return true
    }
    
    
    func print(_ message: Any) {
        Swift.print(">>> \(message)")
    }
 
    
    let kWorkingDirectory      = "--working-directory"
    let kInputFile             = "--input-file"
    let kIntermediateDirectory = "--intermediate-directory"
    let kOutputDirectory       = "--output-directory"
}



