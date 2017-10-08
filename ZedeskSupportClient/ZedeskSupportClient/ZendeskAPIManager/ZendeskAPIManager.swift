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
    
    private init() {
        self.client = ClientInfo.defaultClient()
    }
    
    private func defaultAuthorizationHeader() -> [String:String] {
        let credentialData = "\(self.client.email):\(self.client.password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        return headers
    }
    
    // MARK: - External methods
    func changeClient(newClient:ClientInfo) {
        self.client = newClient
    }
    
    // MARK: - Get Methods
    func getTickets(successBlock: @escaping (Any) -> (), errorBlock: @escaping (Error?) -> ()) {
        Alamofire.request("https://\(self.client.subdomain).zendesk.com/api/v2/views/\(self.client.clientId)/tickets.json",
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers:self.defaultAuthorizationHeader())
            .validate()
            .responseJSON { response in
                if let validJson = response.result.value {
                    successBlock(validJson)
                } else {
                    errorBlock(response.error)
                }
        }
    }
}
