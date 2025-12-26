//
//  File.swift
//  UniFix
//
//  Created by zahraa humaidan on 24/12/2025.
//

import Foundation
struct UserAccount {
    var id: String!
    var fullName: String
    var email: String
    var userType: String?
    init(id: String! , fullName: String, email: String, userType: String?) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.userType = userType
    }
}
