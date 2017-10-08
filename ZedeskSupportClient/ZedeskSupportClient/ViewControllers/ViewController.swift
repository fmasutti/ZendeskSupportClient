//
//  ViewController.swift
//  ZedeskSupportClient
//
//  Created by Frantiesco Masutti on 07/10/17.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ticketsTableView: UITableView!
    var tickets: Tickets?
    var ticketsList = [TicketModel]();
    
    // MARK: View Cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        //Request data from ZendeskAPIManager.
        ZendeskAPIManager.sharedInstance.getTickets(perPageTickets: nil, specificPageURL: nil, successBlock: { (tickets) in
            self.ticketsList = tickets.tickets
            self.ticketsTableView.reloadData()
        }) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
}

// UITableView extension for ViewController
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableView Delegates.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ticketsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  TicketCell.cellIdentifier) as! TicketCell
        cell.loadCellContent(ticket: self.ticketsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
//        return UITableViewAutomaticDimension
//    }
//
    
}




