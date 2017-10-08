//
//  ViewController.swift
//  ZedeskSupportClient
//
//  Created by Frantiesco Masutti on 07/10/17.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import UIKit
import ICSPullToRefresh

class ViewController: UIViewController {
    @IBOutlet weak var ticketsTableView: UITableView!
    
    let perPageTickets = 10
    var tickets: Tickets?
    var ticketsList = [TicketModel]();
    
    // MARK: View Cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ticketsTableView.addInfiniteScrollingWithHandler {
            self.requestTicketsFromZendeskAPI()
        }
        self.ticketsTableView.triggerInfiniteScrolling()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func requestTicketsFromZendeskAPI() {
        if let lastTickets = self.tickets {
            if (lastTickets.nextPage == nil) {
                self.ticketsTableView.setShowsInfiniteScrolling(false)
                return
            }
        }
        
        ZendeskAPIManager.sharedInstance.getTickets(perPageTickets: self.perPageTickets, specificPageURL: self.tickets?.nextPage, successBlock: { (tickets) in
            self.ticketsTableView.infiniteScrollingView?.stopAnimating()
            self.tickets = tickets
            self.ticketsList.append(contentsOf: tickets.tickets)
            self.ticketsTableView.reloadData()
        }) { (error) in
            self.ticketsTableView.infiniteScrollingView?.stopAnimating()
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
}
