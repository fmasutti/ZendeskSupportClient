//
//  ZendeskAPIManager.swift
//  ZedeskSupportClient
//
//  Created by Frantiesco Masutti on 08/10/17.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

final class ZendeskAPIManager {
    static let sharedInstance = ZendeskAPIManager()
    public private(set) var client:ClientInfo!
    var defaultItensPerPage:Int = 20
    
    private init() {
        self.client = ClientInfo.defaultClient()
    }
    
    private func defaultAuthorizationHeader() -> [String:String] {
        let credentialData = "\(self.client.email):\(self.client.password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        return headers
    }
    
    private func defaultPagedParameters(paged:Int?) -> Parameters{
        if let paged = paged {
            if paged < 100 {
                return ["per_page":paged]
            }
        }
        return ["per_page":defaultItensPerPage]
    }
    
    // MARK: - External methods
    func changeClient(newClient:ClientInfo) {
        self.client = newClient
    }
    
    // MARK: - Get List of TicketModel From ZendeskAPI.
    /// Request from ZendeskAPI list of tickets for current Client defined for this Singleton.
    /// - parameter perPageTickets:   The number of itens per page. `self.defaultItensPerPage`.
    /// - parameter specificPageURL:  The url if want to request date of a specific page.
    /// - parameter successBlock:     Escaping block that will return a list with tickets from client.
    /// - parameter errorBlock:       Escaping block that will return if something went wrong during the request.
    func getTickets(perPageTickets:Int?, specificPageURL:String?, successBlock: @escaping (Tickets) -> (),
                    errorBlock: @escaping (Error?) -> ()) {
        
        let urlString:String
        if let specificPageURL = specificPageURL {
            urlString = specificPageURL
        }else {
            urlString = "https://\(self.client.subdomain).zendesk.com/api/v2/views/\(self.client.clientId)/tickets.json"
        }
        
        let parameters = self.defaultPagedParameters(paged: perPageTickets)
        
        Alamofire.request(urlString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers:self.defaultAuthorizationHeader()).validate().responseJSON { response in
                switch response.result {
                case .success:
                    if let jsonReturn = response.result.value as? [String:Any] {
                        let tickets = Tickets(jsonObject: jsonReturn)
                        successBlock(tickets)
                    } else {
                        errorBlock(response.error)
                    }
                case .failure(let error):
                    errorBlock(error)
                }
        }
    }
}

