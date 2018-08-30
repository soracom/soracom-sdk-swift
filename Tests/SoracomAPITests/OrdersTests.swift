// OrdersTests.swift Created by mason on 2018-08-28. Copyright © 2018 Soracom, Inc. All rights reserved.

import XCTest

#if USE_TESTABLE_IMPORT_FOR_IOS_DEMO_APP
    @testable import iOSDemoAppForSoracomAPI
#else
    @testable import SoracomAPI
#endif


#if os(Linux)
extension OrdersTests {
    static var allTests : [(String, (OrdersTests) -> () throws -> Void)] {
        return [
            ("test_basic", test_basic),
        ]
    }
}
#endif


class OrdersTests: BaseTestCase {
    
    func test_getPaymentInformation() {
        let info = Request.getPaymentMethod().wait().parse()
        print(info ?? "nope")
    }
    
    
    func test_listOrders() {
        
        guard
            let products = Request.listProducts().wait().parse(),
            let prodList = products.productList
            else {
                return XCTFail("could not list products")
        }
        
        XCTAssert(prodList.count > 0)
        
        let productCode = prodList[0].productCode
        print(productCode ?? "nope")
    }
    
    
    func test_basic() {
        
        let creds = Client.sharedInstance.synchronousUpdateToken(Client.sharedInstance.credentialsForSandboxUser)

        guard let operatorId = creds?.operatorID else {
            return XCTFail("could not get operatorID 🤔")
        }
        
        // (We fetch the credentials above because in this ase, we need the operatorId to use as a parameter for some of the API calls below.)
        
        let card = CreditCard.testCard
        
        
        let regCardResult = Request.registerWebPayPaymentMethod(creditCard: card).wait().parse()
        XCTAssertNotNil(regCardResult)

        let listResult = Request.listOrders().wait().parse()
        XCTAssertNotNil(listResult)
        
        // NOTE: In the JP coverage type, the backend's validator will reject postal code and state values it doesn't recognize.
        
        let address = ShippingAddressModel(
            city: "Shinjuku",
            state: "東京都",
            zipCode: "162-0812",
            addressLine1: "Line uno",
            addressLine2: "Line dos",
            building: "Great Building Apt. 456",
            companyName: "ACME Corp.",
            department: "Engineering",
            fullName: "John Dorfmaster",
            phoneNumber: "123-4567"
        )
        
        let addShippingAddressResponse = Request.createShippingAddress(model: address, operatorId: operatorId).wait()
        
        guard let addShippingAddressResult = addShippingAddressResponse.parse() else {
            return XCTFail("could not parse result of createShippingAddress")
        }
        
        XCTAssertEqual(addShippingAddressResult.city, address.city)
        XCTAssertEqual(addShippingAddressResult.state, address.state)
        XCTAssertEqual(addShippingAddressResult.zipCode, address.zipCode)
        XCTAssertEqual(addShippingAddressResult.addressLine1, address.addressLine1)
        XCTAssertEqual(addShippingAddressResult.addressLine2, address.addressLine2)
        XCTAssertEqual(addShippingAddressResult.building, address.building)
        XCTAssertEqual(addShippingAddressResult.companyName, address.companyName)
        XCTAssertEqual(addShippingAddressResult.department, address.department)
        XCTAssertEqual(addShippingAddressResult.fullName, address.fullName)
        XCTAssertEqual(addShippingAddressResult.phoneNumber, address.phoneNumber)
        
        let shippingAddressId = addShippingAddressResult.shippingAddressId
        XCTAssertNotNil(shippingAddressId)
          // This test is probably not necessary, because if it was nil, then parsing the GetShippingAddressResponse JSON should have failed.
        
        // GET ADDRESS
        let getRequest  = Request.getShippingAddress(operatorId: operatorId, shippingAddressId: addShippingAddressResult.shippingAddressId)
        let getResponse = getRequest.wait()
        
        guard let getResult = getResponse.parse() else {
            return XCTFail("failed to get up newly-created shipping address")
        }
        
        XCTAssertEqual(getResult.city, address.city)
        XCTAssertEqual(getResult.state, address.state)
        XCTAssertEqual(getResult.zipCode, address.zipCode)
        XCTAssertEqual(getResult.addressLine1, address.addressLine1)
        XCTAssertEqual(getResult.addressLine2, address.addressLine2)
        XCTAssertEqual(getResult.building, address.building)
        XCTAssertEqual(getResult.companyName, address.companyName)
        XCTAssertEqual(getResult.department, address.department)
        XCTAssertEqual(getResult.fullName, address.fullName)
        XCTAssertEqual(getResult.phoneNumber, address.phoneNumber)
        
        let productCodeForPlanKSIM = "4573326590259"
          // SORACOM Air SIM card plan-K size:Nano(for data/SMS) 1 SIM pack
        
        // CREATE ORDER (QUOTATION):
        
        let orderItem = OrderItemModel(productCode: productCodeForPlanKSIM, quantity: 1)
        let createOrderRequest = Request.createQuotation(request: CreateEstimatedOrderRequest(orderItemList: [orderItem], shippingAddressId: shippingAddressId))
        let createOrderResponse = createOrderRequest.wait()
        let createOrderResult = createOrderResponse.parse()
        
        print(createOrderResult ?? "nope")
        
        // let foo = Request.listProducts()
        
        // DELETE ADDRESS
        let deleteAddressResponse = Request.deleteShippingAddress(operatorId: operatorId, shippingAddressId: shippingAddressId).wait()
        print(deleteAddressResponse)
        
        
        // GET IT AND ASSERT 404

//        let order = CreateEstimatedOrderRequest(
//        Request.createQuotation(request: CreateEstimatedOrderRequest)
    }
}
