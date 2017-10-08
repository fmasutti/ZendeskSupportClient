//
//  TicketsJson.swift
//  ZedeskSupportClient
//
//  Created by Frantiesco Masutti on 08/10/17.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation

struct Tickets {
    public private(set)var previousPage:String?
    public private(set)var count:Int?
    public private(set)var tickets:[TicketModel]
    public private(set)var nextPage:String?
}

extension Tickets {
    init(jsonObject:[String:Any]) {
        self.tickets = [TicketModel]()
        if let ticketsJsonFormat = jsonObject["tickets"] as? [NSDictionary] {
            for ticketJsonDic in ticketsJsonFormat {
                tickets.append(TicketModel(jsonObject: ticketJsonDic))
            }
        }
        if let previousPage = jsonObject["previous_page"] as? String {
            self.previousPage = previousPage
        }
        
        if let count = jsonObject["count"] as? Int {
            self.count = count
        }
        
        if let nextPage = jsonObject["next_page"] as? String {
            self.nextPage = nextPage
        }
    }
}
