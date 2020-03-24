//
//  User.swift
//  Friend Face
//
//  Created by Rinalds Domanovs on 24/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

struct User: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}
