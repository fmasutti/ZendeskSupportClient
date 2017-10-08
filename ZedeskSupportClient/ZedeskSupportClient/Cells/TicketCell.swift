//
//  TicketCell.swift
//  ZedeskSupportClient
//
//  Created by Frantiesco Masutti on 08/10/17.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation
import UIKit

class TicketCell: UITableViewCell {
    static let cellIdentifier = "TicketCellIdentifier"
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
    func loadCellContent(ticket:TicketModel) {
        
        if let number = ticket.id {
            self.numberLabel.text = String(format: "%04d", number)
        }
        
        if let status = ticket.status {
            self.statusLabel.text = status
        }
        
        if let description = ticket.description {
            self.descriptionLabel.text = description
        }
        
        if let subject = ticket.subject {
            self.subjectLabel.text = subject
        }
    }
}
