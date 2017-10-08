//
//  TicketModel.swift
//  ZedeskSupportClient
//
//  Created by Frantiesco Masutti on 08/10/17.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation

/// A TicketModel Struct sample model interface from a server json response obj.
struct TicketModel {
    public private(set) var id: Int!
    public private(set) var description: String?
    var subject: String?
    var status: String?
    
    
    /// - Parameters:
    ///   - jsonObject: NSDictionary with Ticket infos to popupale struct content.
    init(jsonObject:NSDictionary) {
        if let id = jsonObject["id"] as? Int {
            self.id = id
        }
        
        if let description = jsonObject["description"] as? String {
            self.description = description
        }
        
        if let subject = jsonObject["subject"] as? String {
            self.subject = subject
        }
        
        if let status = jsonObject["status"] as? String {
            self.status = status
        }
    }
}
