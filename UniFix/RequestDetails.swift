//
//  RequestDetails.swift
//  UniFix
//
//  Created by zahraa humaidan on 16/12/2025.
//

import Foundation
struct Request {
    let id: String
    let subject: String
    let category: String
    let location: String
    let urgency: String
    let description: String
    let contact: String
    let status: String
    let date: Date
    let FullName: String
    
    init(id: String, subject: String, category: String, location: String, urgency: String, description: String, contact: String, status: String, date: Date, FullName: String) {
        self.id = id
        self.subject = subject
        self.category = category
        self.location = location
        self.urgency = urgency
        self.description = description
        self.contact = contact
       self.status = status
        self.date = date
       self.FullName = FullName
    }
    }


