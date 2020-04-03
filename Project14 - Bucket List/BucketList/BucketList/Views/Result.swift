//
//  Result.swift
//  BucketList
//
//  Created by Rinalds Domanovs on 03/04/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
