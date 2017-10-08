//
//  TicketModelTests.swift
//  ZedeskSupportClientTests
//
//  Created by Frantiesco Masutti on 08/10/17.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import XCTest


class TicketModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTicketModelJsonInit() {
        let ticketID = 1
        let myDescription = "MyDescription"
        let mySubject = "MySubject"
        let myStatus = "MyStatus"
        
        let ticket = TicketModel(jsonObject: ["id":ticketID, "description":myDescription, "subject":mySubject, "status":myStatus])
        
        XCTAssert(ticket.id == ticketID)
        XCTAssert(ticket.description == myDescription)
        XCTAssert(ticket.subject == mySubject)
    }
    
}
