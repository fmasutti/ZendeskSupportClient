//
//  ClientInfo.swift
//  ZedeskSupportClient
//
//  Created by Frantiesco Masutti on 08/10/17.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation

//Sample client struct.
struct ClientInfo {
    var clientId: String
    var subdomain: String
    var email: String
    var password: String
    
    init(clientId:String, subdomain:String, email:String, password:String) {
        self.clientId = clientId
        self.subdomain = subdomain
        self.email = email
        self.password = password
    }
    static public func defaultClient() -> ClientInfo {
        return ClientInfo(clientId: "39551161", subdomain: "mxtechtest", email: "acooke+techtest@zendesk.com", password: "mobile")
    }
}
