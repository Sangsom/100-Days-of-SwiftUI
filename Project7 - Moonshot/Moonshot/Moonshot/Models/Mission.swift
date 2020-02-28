//
//  Mission.swift
//  Moonshot
//
//  Created by Rinalds Domanovs on 28/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String

    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
}
