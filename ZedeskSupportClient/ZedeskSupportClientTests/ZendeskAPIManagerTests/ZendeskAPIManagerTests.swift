//
//  ZendeskAPIManagerTests.swift
//  ZedeskSupportClientTests
//
//  Created by Frantiesco Masutti on 08/10/17.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import XCTest

class ZendeskAPIManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMockedData() {
        guard Bundle(for: type(of: self)).path(forResource: "ticketsJson", ofType: "json") != nil else {
            fatalError("ticketsJson.json not found")
        }
    }
    
    func testChangeClient() {
        let defaultClientInfo = ClientInfo.defaultClient()
        let newClientInfo = ClientInfo(clientId: "clientId", subdomain: "test", email: "email@nice.com", password: "12345")
        XCTAssertEqual(defaultClientInfo.clientId, ZendeskAPIManager.sharedInstance.client.clientId)
        XCTAssertEqual(defaultClientInfo.email, ZendeskAPIManager.sharedInstance.client.email)
        XCTAssertEqual(defaultClientInfo.password, ZendeskAPIManager.sharedInstance.client.password)
        XCTAssertEqual(defaultClientInfo.subdomain, ZendeskAPIManager.sharedInstance.client.subdomain)
        ZendeskAPIManager.sharedInstance.changeClient(newClient: newClientInfo)
        XCTAssertEqual(newClientInfo.clientId, ZendeskAPIManager.sharedInstance.client.clientId)
        XCTAssertEqual(newClientInfo.email, ZendeskAPIManager.sharedInstance.client.email)
        XCTAssertEqual(newClientInfo.password, ZendeskAPIManager.sharedInstance.client.password)
        XCTAssertEqual(newClientInfo.subdomain, ZendeskAPIManager.sharedInstance.client.subdomain)
    }
    
    func testAccessForGetTicketsRequestPerformance() {
        measure {
            let contentExpectation = expectation(description: "Description")
            ZendeskAPIManager.sharedInstance.getTickets(perPageTickets: nil, specificPageURL: nil, successBlock: { (tickets) in
                XCTAssertNotNil(tickets, "data should not be nil")
                contentExpectation.fulfill()
            }, errorBlock: { (error) in
                XCTFail("Was not able to access ZendeskAPI  'getTickets' content.")
            })
            
            waitForExpectations(timeout: 10) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
