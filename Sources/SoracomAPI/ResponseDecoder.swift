import Foundation

extension Response {
    
    open func parse() -> T? {
        
        guard let data = data else {
            
            if T.self == NoResponseBody.self {
                // This is a special case. A nil data is expected.
                return NoResponseBody() as? T
            }
            return nil
        }
        
        var result: T? = nil
        
        let d = JSONDecoder()
        
        do {
            if T.self == NoResponseBody.self {
                // Not sure if/how to make this work: return try d.decode(NoResponseBody.self, from: data) as? T
                return NoResponseBody() as? T
                
// ------------------- PUT AUTOGEN HERE:
            } else if T.self == APICallError.self {
                result = try d.decode(APICallError.self, from: data) as? T
            } else if T.self == [APICallError].self {
                result = try d.decode([APICallError].self, from: data) as? T
            } else if T.self == APICallErrorMessage.self {
                result = try d.decode(APICallErrorMessage.self, from: data) as? T
            } else if T.self == [APICallErrorMessage].self {
                result = try d.decode([APICallErrorMessage].self, from: data) as? T
            } else if T.self == APIKeyResponse.self {
                result = try d.decode(APIKeyResponse.self, from: data) as? T
            } else if T.self == [APIKeyResponse].self {
                result = try d.decode([APIKeyResponse].self, from: data) as? T
            } else if T.self == ActionConfig.self {
                result = try d.decode(ActionConfig.self, from: data) as? T
            } else if T.self == [ActionConfig].self {
                result = try d.decode([ActionConfig].self, from: data) as? T
            } else if T.self == ActionConfigProperty.self {
                result = try d.decode(ActionConfigProperty.self, from: data) as? T
            } else if T.self == [ActionConfigProperty].self {
                result = try d.decode([ActionConfigProperty].self, from: data) as? T
            } else if T.self == AirStatsResponse.self {
                result = try d.decode(AirStatsResponse.self, from: data) as? T
            } else if T.self == [AirStatsResponse].self {
                result = try d.decode([AirStatsResponse].self, from: data) as? T
            } else if T.self == AttachRoleRequest.self {
                result = try d.decode(AttachRoleRequest.self, from: data) as? T
            } else if T.self == [AttachRoleRequest].self {
                result = try d.decode([AttachRoleRequest].self, from: data) as? T
            } else if T.self == AttributeUpdate.self {
                result = try d.decode(AttributeUpdate.self, from: data) as? T
            } else if T.self == [AttributeUpdate].self {
                result = try d.decode([AttributeUpdate].self, from: data) as? T
            } else if T.self == AuthKeyResponse.self {
                result = try d.decode(AuthKeyResponse.self, from: data) as? T
            } else if T.self == [AuthKeyResponse].self {
                result = try d.decode([AuthKeyResponse].self, from: data) as? T
            } else if T.self == AuthRequest.self {
                result = try d.decode(AuthRequest.self, from: data) as? T
            } else if T.self == [AuthRequest].self {
                result = try d.decode([AuthRequest].self, from: data) as? T
            } else if T.self == AuthResponse.self {
                result = try d.decode(AuthResponse.self, from: data) as? T
            } else if T.self == [AuthResponse].self {
                result = try d.decode([AuthResponse].self, from: data) as? T
            } else if T.self == BeamCounts.self {
                result = try d.decode(BeamCounts.self, from: data) as? T
            } else if T.self == [BeamCounts].self {
                result = try d.decode([BeamCounts].self, from: data) as? T
            } else if T.self == BeamStatsResponse.self {
                result = try d.decode(BeamStatsResponse.self, from: data) as? T
            } else if T.self == [BeamStatsResponse].self {
                result = try d.decode([BeamStatsResponse].self, from: data) as? T
            } else if T.self == Config.self {
                result = try d.decode(Config.self, from: data) as? T
            } else if T.self == [Config].self {
                result = try d.decode([Config].self, from: data) as? T
            } else if T.self == CouponResponse.self {
                result = try d.decode(CouponResponse.self, from: data) as? T
            } else if T.self == [CouponResponse].self {
                result = try d.decode([CouponResponse].self, from: data) as? T
            } else if T.self == CreateAndUpdateCredentialsModel.self {
                result = try d.decode(CreateAndUpdateCredentialsModel.self, from: data) as? T
            } else if T.self == [CreateAndUpdateCredentialsModel].self {
                result = try d.decode([CreateAndUpdateCredentialsModel].self, from: data) as? T
            } else if T.self == CreateCouponRequest.self {
                result = try d.decode(CreateCouponRequest.self, from: data) as? T
            } else if T.self == [CreateCouponRequest].self {
                result = try d.decode([CreateCouponRequest].self, from: data) as? T
            } else if T.self == CreateCouponResponse.self {
                result = try d.decode(CreateCouponResponse.self, from: data) as? T
            } else if T.self == [CreateCouponResponse].self {
                result = try d.decode([CreateCouponResponse].self, from: data) as? T
            } else if T.self == CreateEstimatedOrderRequest.self {
                result = try d.decode(CreateEstimatedOrderRequest.self, from: data) as? T
            } else if T.self == [CreateEstimatedOrderRequest].self {
                result = try d.decode([CreateEstimatedOrderRequest].self, from: data) as? T
            } else if T.self == CreateEventHandlerRequest.self {
                result = try d.decode(CreateEventHandlerRequest.self, from: data) as? T
            } else if T.self == [CreateEventHandlerRequest].self {
                result = try d.decode([CreateEventHandlerRequest].self, from: data) as? T
            } else if T.self == CreateGroupRequest.self {
                result = try d.decode(CreateGroupRequest.self, from: data) as? T
            } else if T.self == [CreateGroupRequest].self {
                result = try d.decode([CreateGroupRequest].self, from: data) as? T
            } else if T.self == CreateOrUpdateRoleRequest.self {
                result = try d.decode(CreateOrUpdateRoleRequest.self, from: data) as? T
            } else if T.self == [CreateOrUpdateRoleRequest].self {
                result = try d.decode([CreateOrUpdateRoleRequest].self, from: data) as? T
            } else if T.self == CreateRoleResponse.self {
                result = try d.decode(CreateRoleResponse.self, from: data) as? T
            } else if T.self == [CreateRoleResponse].self {
                result = try d.decode([CreateRoleResponse].self, from: data) as? T
            } else if T.self == CreateSubscriberResponse.self {
                result = try d.decode(CreateSubscriberResponse.self, from: data) as? T
            } else if T.self == [CreateSubscriberResponse].self {
                result = try d.decode([CreateSubscriberResponse].self, from: data) as? T
            } else if T.self == CreateUserPasswordRequest.self {
                result = try d.decode(CreateUserPasswordRequest.self, from: data) as? T
            } else if T.self == [CreateUserPasswordRequest].self {
                result = try d.decode([CreateUserPasswordRequest].self, from: data) as? T
            } else if T.self == CreateUserRequest.self {
                result = try d.decode(CreateUserRequest.self, from: data) as? T
            } else if T.self == [CreateUserRequest].self {
                result = try d.decode([CreateUserRequest].self, from: data) as? T
            } else if T.self == CreateVirtualPrivateGatewayRequest.self {
                result = try d.decode(CreateVirtualPrivateGatewayRequest.self, from: data) as? T
            } else if T.self == [CreateVirtualPrivateGatewayRequest].self {
                result = try d.decode([CreateVirtualPrivateGatewayRequest].self, from: data) as? T
            } else if T.self == CreateVpcPeeringConnectionRequest.self {
                result = try d.decode(CreateVpcPeeringConnectionRequest.self, from: data) as? T
            } else if T.self == [CreateVpcPeeringConnectionRequest].self {
                result = try d.decode([CreateVpcPeeringConnectionRequest].self, from: data) as? T
            } else if T.self == CredentialsModel.self {
                result = try d.decode(CredentialsModel.self, from: data) as? T
            } else if T.self == [CredentialsModel].self {
                result = try d.decode([CredentialsModel].self, from: data) as? T
            } else if T.self == CreditCard.self {
                result = try d.decode(CreditCard.self, from: data) as? T
            } else if T.self == [CreditCard].self {
                result = try d.decode([CreditCard].self, from: data) as? T
            } else if T.self == DailyBill.self {
                result = try d.decode(DailyBill.self, from: data) as? T
            } else if T.self == [DailyBill].self {
                result = try d.decode([DailyBill].self, from: data) as? T
            } else if T.self == DailyBillResponse.self {
                result = try d.decode(DailyBillResponse.self, from: data) as? T
            } else if T.self == [DailyBillResponse].self {
                result = try d.decode([DailyBillResponse].self, from: data) as? T
            } else if T.self == DataEntry.self {
                result = try d.decode(DataEntry.self, from: data) as? T
            } else if T.self == [DataEntry].self {
                result = try d.decode([DataEntry].self, from: data) as? T
            } else if T.self == DataSourceResourceMetadata.self {
                result = try d.decode(DataSourceResourceMetadata.self, from: data) as? T
            } else if T.self == [DataSourceResourceMetadata].self {
                result = try d.decode([DataSourceResourceMetadata].self, from: data) as? T
            } else if T.self == DataTrafficStats.self {
                result = try d.decode(DataTrafficStats.self, from: data) as? T
            } else if T.self == [DataTrafficStats].self {
                result = try d.decode([DataTrafficStats].self, from: data) as? T
            } else if T.self == Device.self {
                result = try d.decode(Device.self, from: data) as? T
            } else if T.self == [Device].self {
                result = try d.decode([Device].self, from: data) as? T
            } else if T.self == DeviceObjectModel.self {
                result = try d.decode(DeviceObjectModel.self, from: data) as? T
            } else if T.self == [DeviceObjectModel].self {
                result = try d.decode([DeviceObjectModel].self, from: data) as? T
            } else if T.self == EnableMFAOTPResponse.self {
                result = try d.decode(EnableMFAOTPResponse.self, from: data) as? T
            } else if T.self == [EnableMFAOTPResponse].self {
                result = try d.decode([EnableMFAOTPResponse].self, from: data) as? T
            } else if T.self == ErrorType.self {
                result = try d.decode(ErrorType.self, from: data) as? T
            } else if T.self == [ErrorType].self {
                result = try d.decode([ErrorType].self, from: data) as? T
            } else if T.self == EstimatedOrderItemModel.self {
                result = try d.decode(EstimatedOrderItemModel.self, from: data) as? T
            } else if T.self == [EstimatedOrderItemModel].self {
                result = try d.decode([EstimatedOrderItemModel].self, from: data) as? T
            } else if T.self == EstimatedOrderModel.self {
                result = try d.decode(EstimatedOrderModel.self, from: data) as? T
            } else if T.self == [EstimatedOrderModel].self {
                result = try d.decode([EstimatedOrderModel].self, from: data) as? T
            } else if T.self == EventHandlerModel.self {
                result = try d.decode(EventHandlerModel.self, from: data) as? T
            } else if T.self == [EventHandlerModel].self {
                result = try d.decode([EventHandlerModel].self, from: data) as? T
            } else if T.self == ExpiryTime.self {
                result = try d.decode(ExpiryTime.self, from: data) as? T
            } else if T.self == [ExpiryTime].self {
                result = try d.decode([ExpiryTime].self, from: data) as? T
            } else if T.self == ExportRequest.self {
                result = try d.decode(ExportRequest.self, from: data) as? T
            } else if T.self == [ExportRequest].self {
                result = try d.decode([ExportRequest].self, from: data) as? T
            } else if T.self == FileExportResponse.self {
                result = try d.decode(FileExportResponse.self, from: data) as? T
            } else if T.self == [FileExportResponse].self {
                result = try d.decode([FileExportResponse].self, from: data) as? T
            } else if T.self == FunnelConfiguration.self {
                result = try d.decode(FunnelConfiguration.self, from: data) as? T
            } else if T.self == [FunnelConfiguration].self {
                result = try d.decode([FunnelConfiguration].self, from: data) as? T
            } else if T.self == FunnelDestination.self {
                result = try d.decode(FunnelDestination.self, from: data) as? T
            } else if T.self == [FunnelDestination].self {
                result = try d.decode([FunnelDestination].self, from: data) as? T
            } else if T.self == GatePeer.self {
                result = try d.decode(GatePeer.self, from: data) as? T
            } else if T.self == [GatePeer].self {
                result = try d.decode([GatePeer].self, from: data) as? T
            } else if T.self == GenerateOperatorsAuthKeyResponse.self {
                result = try d.decode(GenerateOperatorsAuthKeyResponse.self, from: data) as? T
            } else if T.self == [GenerateOperatorsAuthKeyResponse].self {
                result = try d.decode([GenerateOperatorsAuthKeyResponse].self, from: data) as? T
            } else if T.self == GenerateTokenRequest.self {
                result = try d.decode(GenerateTokenRequest.self, from: data) as? T
            } else if T.self == [GenerateTokenRequest].self {
                result = try d.decode([GenerateTokenRequest].self, from: data) as? T
            } else if T.self == GenerateTokenResponse.self {
                result = try d.decode(GenerateTokenResponse.self, from: data) as? T
            } else if T.self == [GenerateTokenResponse].self {
                result = try d.decode([GenerateTokenResponse].self, from: data) as? T
            } else if T.self == GenerateUserAuthKeyResponse.self {
                result = try d.decode(GenerateUserAuthKeyResponse.self, from: data) as? T
            } else if T.self == [GenerateUserAuthKeyResponse].self {
                result = try d.decode([GenerateUserAuthKeyResponse].self, from: data) as? T
            } else if T.self == GetBillingHistoryResponse.self {
                result = try d.decode(GetBillingHistoryResponse.self, from: data) as? T
            } else if T.self == [GetBillingHistoryResponse].self {
                result = try d.decode([GetBillingHistoryResponse].self, from: data) as? T
            } else if T.self == GetExportedFileResponse.self {
                result = try d.decode(GetExportedFileResponse.self, from: data) as? T
            } else if T.self == [GetExportedFileResponse].self {
                result = try d.decode([GetExportedFileResponse].self, from: data) as? T
            } else if T.self == GetLatestBill.self {
                result = try d.decode(GetLatestBill.self, from: data) as? T
            } else if T.self == [GetLatestBill].self {
                result = try d.decode([GetLatestBill].self, from: data) as? T
            } else if T.self == GetOperatorResponse.self {
                result = try d.decode(GetOperatorResponse.self, from: data) as? T
            } else if T.self == [GetOperatorResponse].self {
                result = try d.decode([GetOperatorResponse].self, from: data) as? T
            } else if T.self == GetOrderResponse.self {
                result = try d.decode(GetOrderResponse.self, from: data) as? T
            } else if T.self == [GetOrderResponse].self {
                result = try d.decode([GetOrderResponse].self, from: data) as? T
            } else if T.self == GetPaymentMethodResult.self {
                result = try d.decode(GetPaymentMethodResult.self, from: data) as? T
            } else if T.self == [GetPaymentMethodResult].self {
                result = try d.decode([GetPaymentMethodResult].self, from: data) as? T
            } else if T.self == GetPaymentTransactionResult.self {
                result = try d.decode(GetPaymentTransactionResult.self, from: data) as? T
            } else if T.self == [GetPaymentTransactionResult].self {
                result = try d.decode([GetPaymentTransactionResult].self, from: data) as? T
            } else if T.self == GetShippingAddressResponse.self {
                result = try d.decode(GetShippingAddressResponse.self, from: data) as? T
            } else if T.self == [GetShippingAddressResponse].self {
                result = try d.decode([GetShippingAddressResponse].self, from: data) as? T
            } else if T.self == GetSignupTokenRequest.self {
                result = try d.decode(GetSignupTokenRequest.self, from: data) as? T
            } else if T.self == [GetSignupTokenRequest].self {
                result = try d.decode([GetSignupTokenRequest].self, from: data) as? T
            } else if T.self == GetSignupTokenResponse.self {
                result = try d.decode(GetSignupTokenResponse.self, from: data) as? T
            } else if T.self == [GetSignupTokenResponse].self {
                result = try d.decode([GetSignupTokenResponse].self, from: data) as? T
            } else if T.self == GetUserPasswordResponse.self {
                result = try d.decode(GetUserPasswordResponse.self, from: data) as? T
            } else if T.self == [GetUserPasswordResponse].self {
                result = try d.decode([GetUserPasswordResponse].self, from: data) as? T
            } else if T.self == GetUserPermissionResponse.self {
                result = try d.decode(GetUserPermissionResponse.self, from: data) as? T
            } else if T.self == [GetUserPermissionResponse].self {
                result = try d.decode([GetUserPermissionResponse].self, from: data) as? T
            } else if T.self == Group.self {
                result = try d.decode(Group.self, from: data) as? T
            } else if T.self == [Group].self {
                result = try d.decode([Group].self, from: data) as? T
            } else if T.self == GroupConfigurationUpdateRequest.self {
                result = try d.decode(GroupConfigurationUpdateRequest.self, from: data) as? T
            } else if T.self == [GroupConfigurationUpdateRequest].self {
                result = try d.decode([GroupConfigurationUpdateRequest].self, from: data) as? T
            } else if T.self == ImeiLock.self {
                result = try d.decode(ImeiLock.self, from: data) as? T
            } else if T.self == [ImeiLock].self {
                result = try d.decode([ImeiLock].self, from: data) as? T
            } else if T.self == InitRequest.self {
                result = try d.decode(InitRequest.self, from: data) as? T
            } else if T.self == [InitRequest].self {
                result = try d.decode([InitRequest].self, from: data) as? T
            } else if T.self == InsertAirStatsRequest.self {
                result = try d.decode(InsertAirStatsRequest.self, from: data) as? T
            } else if T.self == [InsertAirStatsRequest].self {
                result = try d.decode([InsertAirStatsRequest].self, from: data) as? T
            } else if T.self == InsertBeamStatsRequest.self {
                result = try d.decode(InsertBeamStatsRequest.self, from: data) as? T
            } else if T.self == [InsertBeamStatsRequest].self {
                result = try d.decode([InsertBeamStatsRequest].self, from: data) as? T
            } else if T.self == IpAddressMapEntry.self {
                result = try d.decode(IpAddressMapEntry.self, from: data) as? T
            } else if T.self == [IpAddressMapEntry].self {
                result = try d.decode([IpAddressMapEntry].self, from: data) as? T
            } else if T.self == IssueEmailChangeTokenRequest.self {
                result = try d.decode(IssueEmailChangeTokenRequest.self, from: data) as? T
            } else if T.self == [IssueEmailChangeTokenRequest].self {
                result = try d.decode([IssueEmailChangeTokenRequest].self, from: data) as? T
            } else if T.self == IssuePasswordResetTokenRequest.self {
                result = try d.decode(IssuePasswordResetTokenRequest.self, from: data) as? T
            } else if T.self == [IssuePasswordResetTokenRequest].self {
                result = try d.decode([IssuePasswordResetTokenRequest].self, from: data) as? T
            } else if T.self == IssueSubscriberTransferTokenRequest.self {
                result = try d.decode(IssueSubscriberTransferTokenRequest.self, from: data) as? T
            } else if T.self == [IssueSubscriberTransferTokenRequest].self {
                result = try d.decode([IssueSubscriberTransferTokenRequest].self, from: data) as? T
            } else if T.self == IssueSubscriberTransferTokenResponse.self {
                result = try d.decode(IssueSubscriberTransferTokenResponse.self, from: data) as? T
            } else if T.self == [IssueSubscriberTransferTokenResponse].self {
                result = try d.decode([IssueSubscriberTransferTokenResponse].self, from: data) as? T
            } else if T.self == JunctionInspectionConfiguration.self {
                result = try d.decode(JunctionInspectionConfiguration.self, from: data) as? T
            } else if T.self == [JunctionInspectionConfiguration].self {
                result = try d.decode([JunctionInspectionConfiguration].self, from: data) as? T
            } else if T.self == JunctionMirroringConfiguration.self {
                result = try d.decode(JunctionMirroringConfiguration.self, from: data) as? T
            } else if T.self == [JunctionMirroringConfiguration].self {
                result = try d.decode([JunctionMirroringConfiguration].self, from: data) as? T
            } else if T.self == JunctionMirroringPeer.self {
                result = try d.decode(JunctionMirroringPeer.self, from: data) as? T
            } else if T.self == [JunctionMirroringPeer].self {
                result = try d.decode([JunctionMirroringPeer].self, from: data) as? T
            } else if T.self == JunctionRedirectionConfiguration.self {
                result = try d.decode(JunctionRedirectionConfiguration.self, from: data) as? T
            } else if T.self == [JunctionRedirectionConfiguration].self {
                result = try d.decode([JunctionRedirectionConfiguration].self, from: data) as? T
            } else if T.self == LagoonRegistrationRequest.self {
                result = try d.decode(LagoonRegistrationRequest.self, from: data) as? T
            } else if T.self == [LagoonRegistrationRequest].self {
                result = try d.decode([LagoonRegistrationRequest].self, from: data) as? T
            } else if T.self == LagoonRegistrationResponse.self {
                result = try d.decode(LagoonRegistrationResponse.self, from: data) as? T
            } else if T.self == [LagoonRegistrationResponse].self {
                result = try d.decode([LagoonRegistrationResponse].self, from: data) as? T
            } else if T.self == LagoonUser.self {
                result = try d.decode(LagoonUser.self, from: data) as? T
            } else if T.self == [LagoonUser].self {
                result = try d.decode([LagoonUser].self, from: data) as? T
            } else if T.self == LagoonUserCreationRequest.self {
                result = try d.decode(LagoonUserCreationRequest.self, from: data) as? T
            } else if T.self == [LagoonUserCreationRequest].self {
                result = try d.decode([LagoonUserCreationRequest].self, from: data) as? T
            } else if T.self == LagoonUserCreationResponse.self {
                result = try d.decode(LagoonUserCreationResponse.self, from: data) as? T
            } else if T.self == [LagoonUserCreationResponse].self {
                result = try d.decode([LagoonUserCreationResponse].self, from: data) as? T
            } else if T.self == LagoonUserEmailUpdatingRequest.self {
                result = try d.decode(LagoonUserEmailUpdatingRequest.self, from: data) as? T
            } else if T.self == [LagoonUserEmailUpdatingRequest].self {
                result = try d.decode([LagoonUserEmailUpdatingRequest].self, from: data) as? T
            } else if T.self == LagoonUserPasswordUpdatingRequest.self {
                result = try d.decode(LagoonUserPasswordUpdatingRequest.self, from: data) as? T
            } else if T.self == [LagoonUserPasswordUpdatingRequest].self {
                result = try d.decode([LagoonUserPasswordUpdatingRequest].self, from: data) as? T
            } else if T.self == LagoonUserPermissionUpdatingRequest.self {
                result = try d.decode(LagoonUserPermissionUpdatingRequest.self, from: data) as? T
            } else if T.self == [LagoonUserPermissionUpdatingRequest].self {
                result = try d.decode([LagoonUserPermissionUpdatingRequest].self, from: data) as? T
            } else if T.self == LastSeen.self {
                result = try d.decode(LastSeen.self, from: data) as? T
            } else if T.self == [LastSeen].self {
                result = try d.decode([LastSeen].self, from: data) as? T
            } else if T.self == ListCouponResponse.self {
                result = try d.decode(ListCouponResponse.self, from: data) as? T
            } else if T.self == [ListCouponResponse].self {
                result = try d.decode([ListCouponResponse].self, from: data) as? T
            } else if T.self == ListOrderResponse.self {
                result = try d.decode(ListOrderResponse.self, from: data) as? T
            } else if T.self == [ListOrderResponse].self {
                result = try d.decode([ListOrderResponse].self, from: data) as? T
            } else if T.self == ListOrderedSubscriberResponse.self {
                result = try d.decode(ListOrderedSubscriberResponse.self, from: data) as? T
            } else if T.self == [ListOrderedSubscriberResponse].self {
                result = try d.decode([ListOrderedSubscriberResponse].self, from: data) as? T
            } else if T.self == ListPaymentStatementResponse.self {
                result = try d.decode(ListPaymentStatementResponse.self, from: data) as? T
            } else if T.self == [ListPaymentStatementResponse].self {
                result = try d.decode([ListPaymentStatementResponse].self, from: data) as? T
            } else if T.self == ListProductResponse.self {
                result = try d.decode(ListProductResponse.self, from: data) as? T
            } else if T.self == [ListProductResponse].self {
                result = try d.decode([ListProductResponse].self, from: data) as? T
            } else if T.self == ListRolesResponse.self {
                result = try d.decode(ListRolesResponse.self, from: data) as? T
            } else if T.self == [ListRolesResponse].self {
                result = try d.decode([ListRolesResponse].self, from: data) as? T
            } else if T.self == ListShippingAddressResponse.self {
                result = try d.decode(ListShippingAddressResponse.self, from: data) as? T
            } else if T.self == [ListShippingAddressResponse].self {
                result = try d.decode([ListShippingAddressResponse].self, from: data) as? T
            } else if T.self == ListSubOperatorsResponse.self {
                result = try d.decode(ListSubOperatorsResponse.self, from: data) as? T
            } else if T.self == [ListSubOperatorsResponse].self {
                result = try d.decode([ListSubOperatorsResponse].self, from: data) as? T
            } else if T.self == LogEntry.self {
                result = try d.decode(LogEntry.self, from: data) as? T
            } else if T.self == [LogEntry].self {
                result = try d.decode([LogEntry].self, from: data) as? T
            } else if T.self == LoraData.self {
                result = try d.decode(LoraData.self, from: data) as? T
            } else if T.self == [LoraData].self {
                result = try d.decode([LoraData].self, from: data) as? T
            } else if T.self == LoraDevice.self {
                result = try d.decode(LoraDevice.self, from: data) as? T
            } else if T.self == [LoraDevice].self {
                result = try d.decode([LoraDevice].self, from: data) as? T
            } else if T.self == LoraGateway.self {
                result = try d.decode(LoraGateway.self, from: data) as? T
            } else if T.self == [LoraGateway].self {
                result = try d.decode([LoraGateway].self, from: data) as? T
            } else if T.self == LoraNetworkSet.self {
                result = try d.decode(LoraNetworkSet.self, from: data) as? T
            } else if T.self == [LoraNetworkSet].self {
                result = try d.decode([LoraNetworkSet].self, from: data) as? T
            } else if T.self == MFAAuthenticationRequest.self {
                result = try d.decode(MFAAuthenticationRequest.self, from: data) as? T
            } else if T.self == [MFAAuthenticationRequest].self {
                result = try d.decode([MFAAuthenticationRequest].self, from: data) as? T
            } else if T.self == MFAIssueRevokingTokenRequest.self {
                result = try d.decode(MFAIssueRevokingTokenRequest.self, from: data) as? T
            } else if T.self == [MFAIssueRevokingTokenRequest].self {
                result = try d.decode([MFAIssueRevokingTokenRequest].self, from: data) as? T
            } else if T.self == MFARevokingTokenVerifyRequest.self {
                result = try d.decode(MFARevokingTokenVerifyRequest.self, from: data) as? T
            } else if T.self == [MFARevokingTokenVerifyRequest].self {
                result = try d.decode([MFARevokingTokenVerifyRequest].self, from: data) as? T
            } else if T.self == MFAStatusOfUseResponse.self {
                result = try d.decode(MFAStatusOfUseResponse.self, from: data) as? T
            } else if T.self == [MFAStatusOfUseResponse].self {
                result = try d.decode([MFAStatusOfUseResponse].self, from: data) as? T
            } else if T.self == Map.self {
                result = try d.decode(Map.self, from: data) as? T
            } else if T.self == [Map].self {
                result = try d.decode([Map].self, from: data) as? T
            } else if T.self == MapstringDataTrafficStats.self {
                result = try d.decode(MapstringDataTrafficStats.self, from: data) as? T
            } else if T.self == [MapstringDataTrafficStats].self {
                result = try d.decode([MapstringDataTrafficStats].self, from: data) as? T
            } else if T.self == Mapstringstring.self {
                result = try d.decode(Mapstringstring.self, from: data) as? T
            } else if T.self == [Mapstringstring].self {
                result = try d.decode([Mapstringstring].self, from: data) as? T
            } else if T.self == MonthlyBill.self {
                result = try d.decode(MonthlyBill.self, from: data) as? T
            } else if T.self == [MonthlyBill].self {
                result = try d.decode([MonthlyBill].self, from: data) as? T
            } else if T.self == ObjectInstance.self {
                result = try d.decode(ObjectInstance.self, from: data) as? T
            } else if T.self == [ObjectInstance].self {
                result = try d.decode([ObjectInstance].self, from: data) as? T
            } else if T.self == OpenGateRequest.self {
                result = try d.decode(OpenGateRequest.self, from: data) as? T
            } else if T.self == [OpenGateRequest].self {
                result = try d.decode([OpenGateRequest].self, from: data) as? T
            } else if T.self == OperatorMFAVerifyingResponse.self {
                result = try d.decode(OperatorMFAVerifyingResponse.self, from: data) as? T
            } else if T.self == [OperatorMFAVerifyingResponse].self {
                result = try d.decode([OperatorMFAVerifyingResponse].self, from: data) as? T
            } else if T.self == OrderItemModel.self {
                result = try d.decode(OrderItemModel.self, from: data) as? T
            } else if T.self == [OrderItemModel].self {
                result = try d.decode([OrderItemModel].self, from: data) as? T
            } else if T.self == OrderedSubscriber.self {
                result = try d.decode(OrderedSubscriber.self, from: data) as? T
            } else if T.self == [OrderedSubscriber].self {
                result = try d.decode([OrderedSubscriber].self, from: data) as? T
            } else if T.self == PaymentAmount.self {
                result = try d.decode(PaymentAmount.self, from: data) as? T
            } else if T.self == [PaymentAmount].self {
                result = try d.decode([PaymentAmount].self, from: data) as? T
            } else if T.self == PaymentDescription.self {
                result = try d.decode(PaymentDescription.self, from: data) as? T
            } else if T.self == [PaymentDescription].self {
                result = try d.decode([PaymentDescription].self, from: data) as? T
            } else if T.self == PaymentStatementResponse.self {
                result = try d.decode(PaymentStatementResponse.self, from: data) as? T
            } else if T.self == [PaymentStatementResponse].self {
                result = try d.decode([PaymentStatementResponse].self, from: data) as? T
            } else if T.self == ProductModel.self {
                result = try d.decode(ProductModel.self, from: data) as? T
            } else if T.self == [ProductModel].self {
                result = try d.decode([ProductModel].self, from: data) as? T
            } else if T.self == PutIpAddressMapEntryRequest.self {
                result = try d.decode(PutIpAddressMapEntryRequest.self, from: data) as? T
            } else if T.self == [PutIpAddressMapEntryRequest].self {
                result = try d.decode([PutIpAddressMapEntryRequest].self, from: data) as? T
            } else if T.self == RegisterGatePeerRequest.self {
                result = try d.decode(RegisterGatePeerRequest.self, from: data) as? T
            } else if T.self == [RegisterGatePeerRequest].self {
                result = try d.decode([RegisterGatePeerRequest].self, from: data) as? T
            } else if T.self == RegisterLoraDeviceRequest.self {
                result = try d.decode(RegisterLoraDeviceRequest.self, from: data) as? T
            } else if T.self == [RegisterLoraDeviceRequest].self {
                result = try d.decode([RegisterLoraDeviceRequest].self, from: data) as? T
            } else if T.self == RegisterOperatorsRequest.self {
                result = try d.decode(RegisterOperatorsRequest.self, from: data) as? T
            } else if T.self == [RegisterOperatorsRequest].self {
                result = try d.decode([RegisterOperatorsRequest].self, from: data) as? T
            } else if T.self == RegisterPayerInformationModel.self {
                result = try d.decode(RegisterPayerInformationModel.self, from: data) as? T
            } else if T.self == [RegisterPayerInformationModel].self {
                result = try d.decode([RegisterPayerInformationModel].self, from: data) as? T
            } else if T.self == RegisterSubscribersRequest.self {
                result = try d.decode(RegisterSubscribersRequest.self, from: data) as? T
            } else if T.self == [RegisterSubscribersRequest].self {
                result = try d.decode([RegisterSubscribersRequest].self, from: data) as? T
            } else if T.self == ResourceInstance.self {
                result = try d.decode(ResourceInstance.self, from: data) as? T
            } else if T.self == [ResourceInstance].self {
                result = try d.decode([ResourceInstance].self, from: data) as? T
            } else if T.self == RoleResponse.self {
                result = try d.decode(RoleResponse.self, from: data) as? T
            } else if T.self == [RoleResponse].self {
                result = try d.decode([RoleResponse].self, from: data) as? T
            } else if T.self == RuleConfig.self {
                result = try d.decode(RuleConfig.self, from: data) as? T
            } else if T.self == [RuleConfig].self {
                result = try d.decode([RuleConfig].self, from: data) as? T
            } else if T.self == RuleConfigProperty.self {
                result = try d.decode(RuleConfigProperty.self, from: data) as? T
            } else if T.self == [RuleConfigProperty].self {
                result = try d.decode([RuleConfigProperty].self, from: data) as? T
            } else if T.self == SessionEvent.self {
                result = try d.decode(SessionEvent.self, from: data) as? T
            } else if T.self == [SessionEvent].self {
                result = try d.decode([SessionEvent].self, from: data) as? T
            } else if T.self == SessionStatus.self {
                result = try d.decode(SessionStatus.self, from: data) as? T
            } else if T.self == [SessionStatus].self {
                result = try d.decode([SessionStatus].self, from: data) as? T
            } else if T.self == SetDeviceObjectModelScopeRequest.self {
                result = try d.decode(SetDeviceObjectModelScopeRequest.self, from: data) as? T
            } else if T.self == [SetDeviceObjectModelScopeRequest].self {
                result = try d.decode([SetDeviceObjectModelScopeRequest].self, from: data) as? T
            } else if T.self == SetGroupRequest.self {
                result = try d.decode(SetGroupRequest.self, from: data) as? T
            } else if T.self == [SetGroupRequest].self {
                result = try d.decode([SetGroupRequest].self, from: data) as? T
            } else if T.self == SetImeiLockRequest.self {
                result = try d.decode(SetImeiLockRequest.self, from: data) as? T
            } else if T.self == [SetImeiLockRequest].self {
                result = try d.decode([SetImeiLockRequest].self, from: data) as? T
            } else if T.self == SetNetworkSetRequest.self {
                result = try d.decode(SetNetworkSetRequest.self, from: data) as? T
            } else if T.self == [SetNetworkSetRequest].self {
                result = try d.decode([SetNetworkSetRequest].self, from: data) as? T
            } else if T.self == SetUserPermissionRequest.self {
                result = try d.decode(SetUserPermissionRequest.self, from: data) as? T
            } else if T.self == [SetUserPermissionRequest].self {
                result = try d.decode([SetUserPermissionRequest].self, from: data) as? T
            } else if T.self == ShippingAddressModel.self {
                result = try d.decode(ShippingAddressModel.self, from: data) as? T
            } else if T.self == [ShippingAddressModel].self {
                result = try d.decode([ShippingAddressModel].self, from: data) as? T
            } else if T.self == ShippingCostModel.self {
                result = try d.decode(ShippingCostModel.self, from: data) as? T
            } else if T.self == [ShippingCostModel].self {
                result = try d.decode([ShippingCostModel].self, from: data) as? T
            } else if T.self == SigfoxData.self {
                result = try d.decode(SigfoxData.self, from: data) as? T
            } else if T.self == [SigfoxData].self {
                result = try d.decode([SigfoxData].self, from: data) as? T
            } else if T.self == SigfoxDevice.self {
                result = try d.decode(SigfoxDevice.self, from: data) as? T
            } else if T.self == [SigfoxDevice].self {
                result = try d.decode([SigfoxDevice].self, from: data) as? T
            } else if T.self == SigfoxRegistrationRequest.self {
                result = try d.decode(SigfoxRegistrationRequest.self, from: data) as? T
            } else if T.self == [SigfoxRegistrationRequest].self {
                result = try d.decode([SigfoxRegistrationRequest].self, from: data) as? T
            } else if T.self == SmsForwardingReport.self {
                result = try d.decode(SmsForwardingReport.self, from: data) as? T
            } else if T.self == [SmsForwardingReport].self {
                result = try d.decode([SmsForwardingReport].self, from: data) as? T
            } else if T.self == SmsForwardingRequest.self {
                result = try d.decode(SmsForwardingRequest.self, from: data) as? T
            } else if T.self == [SmsForwardingRequest].self {
                result = try d.decode([SmsForwardingRequest].self, from: data) as? T
            } else if T.self == SoracomBeamStats.self {
                result = try d.decode(SoracomBeamStats.self, from: data) as? T
            } else if T.self == [SoracomBeamStats].self {
                result = try d.decode([SoracomBeamStats].self, from: data) as? T
            } else if T.self == Subscriber.self {
                result = try d.decode(Subscriber.self, from: data) as? T
            } else if T.self == [Subscriber].self {
                result = try d.decode([Subscriber].self, from: data) as? T
            } else if T.self == SupportTokenResponse.self {
                result = try d.decode(SupportTokenResponse.self, from: data) as? T
            } else if T.self == [SupportTokenResponse].self {
                result = try d.decode([SupportTokenResponse].self, from: data) as? T
            } else if T.self == Tag.self {
                result = try d.decode(Tag.self, from: data) as? T
            } else if T.self == [Tag].self {
                result = try d.decode([Tag].self, from: data) as? T
            } else if T.self == TagUpdateRequest.self {
                result = try d.decode(TagUpdateRequest.self, from: data) as? T
            } else if T.self == [TagUpdateRequest].self {
                result = try d.decode([TagUpdateRequest].self, from: data) as? T
            } else if T.self == UpdateEventHandlerRequest.self {
                result = try d.decode(UpdateEventHandlerRequest.self, from: data) as? T
            } else if T.self == [UpdateEventHandlerRequest].self {
                result = try d.decode([UpdateEventHandlerRequest].self, from: data) as? T
            } else if T.self == UpdatePasswordRequest.self {
                result = try d.decode(UpdatePasswordRequest.self, from: data) as? T
            } else if T.self == [UpdatePasswordRequest].self {
                result = try d.decode([UpdatePasswordRequest].self, from: data) as? T
            } else if T.self == UpdatePermissionRequest.self {
                result = try d.decode(UpdatePermissionRequest.self, from: data) as? T
            } else if T.self == [UpdatePermissionRequest].self {
                result = try d.decode([UpdatePermissionRequest].self, from: data) as? T
            } else if T.self == UpdateSpeedClassRequest.self {
                result = try d.decode(UpdateSpeedClassRequest.self, from: data) as? T
            } else if T.self == [UpdateSpeedClassRequest].self {
                result = try d.decode([UpdateSpeedClassRequest].self, from: data) as? T
            } else if T.self == UpdateUserRequest.self {
                result = try d.decode(UpdateUserRequest.self, from: data) as? T
            } else if T.self == [UpdateUserRequest].self {
                result = try d.decode([UpdateUserRequest].self, from: data) as? T
            } else if T.self == UserDetailResponse.self {
                result = try d.decode(UserDetailResponse.self, from: data) as? T
            } else if T.self == [UserDetailResponse].self {
                result = try d.decode([UserDetailResponse].self, from: data) as? T
            } else if T.self == VerifyEmailChangeTokenRequest.self {
                result = try d.decode(VerifyEmailChangeTokenRequest.self, from: data) as? T
            } else if T.self == [VerifyEmailChangeTokenRequest].self {
                result = try d.decode([VerifyEmailChangeTokenRequest].self, from: data) as? T
            } else if T.self == VerifyOperatorsRequest.self {
                result = try d.decode(VerifyOperatorsRequest.self, from: data) as? T
            } else if T.self == [VerifyOperatorsRequest].self {
                result = try d.decode([VerifyOperatorsRequest].self, from: data) as? T
            } else if T.self == VerifyPasswordResetTokenRequest.self {
                result = try d.decode(VerifyPasswordResetTokenRequest.self, from: data) as? T
            } else if T.self == [VerifyPasswordResetTokenRequest].self {
                result = try d.decode([VerifyPasswordResetTokenRequest].self, from: data) as? T
            } else if T.self == VerifySubscriberTransferTokenRequest.self {
                result = try d.decode(VerifySubscriberTransferTokenRequest.self, from: data) as? T
            } else if T.self == [VerifySubscriberTransferTokenRequest].self {
                result = try d.decode([VerifySubscriberTransferTokenRequest].self, from: data) as? T
            } else if T.self == VerifySubscriberTransferTokenResponse.self {
                result = try d.decode(VerifySubscriberTransferTokenResponse.self, from: data) as? T
            } else if T.self == [VerifySubscriberTransferTokenResponse].self {
                result = try d.decode([VerifySubscriberTransferTokenResponse].self, from: data) as? T
            } else if T.self == VirtualPrivateGateway.self {
                result = try d.decode(VirtualPrivateGateway.self, from: data) as? T
            } else if T.self == [VirtualPrivateGateway].self {
                result = try d.decode([VirtualPrivateGateway].self, from: data) as? T
            } else if T.self == VpcPeeringConnection.self {
                result = try d.decode(VpcPeeringConnection.self, from: data) as? T
            } else if T.self == [VpcPeeringConnection].self {
                result = try d.decode([VpcPeeringConnection].self, from: data) as? T

// --------------------END AUTOGEN
                
            } else {
                fatalError("FIXME: type not handled: \(T.self)")
            }
        } catch let err {
            Metrics.record(type: .decodeFailure, description: "\(self).parse() failed", error: err, data: data)
        }
        return result;
    }
}
