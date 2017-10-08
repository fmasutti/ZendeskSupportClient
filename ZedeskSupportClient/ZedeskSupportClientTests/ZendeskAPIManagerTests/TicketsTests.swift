//
//  TicketsTests.swift
//  ZedeskSupportClientTests
//
//  Created by Frantiesco Masutti on 08/10/17.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import XCTest

class TicketsTests: XCTestCase {
    var tickets:Tickets?
    
    override func setUp() {
        super.setUp()
        let path = Bundle.main.url(forResource: "ticketsJson", withExtension: "json")!
        let jsonData = try! NSData(contentsOf: path, options: .mappedIfSafe)
        let jsonResult = try! JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
        tickets = Tickets(jsonObject: jsonResult!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTicketsJsonInit() {
        XCTAssert(self.tickets?.nextPage! == "https://mxtechtest.zendesk.com/api/v2/views/39551161/tickets.json?page=2&per_page=5")

        XCTAssert(self.tickets?.nextPage! == "https://mxtechtest.zendesk.com/api/v2/views/39551161/tickets.json?page=2&per_page=5")
        XCTAssertNil(self.tickets!.previousPage)
        XCTAssert(self.tickets!.count == 45)
    }
    
}

