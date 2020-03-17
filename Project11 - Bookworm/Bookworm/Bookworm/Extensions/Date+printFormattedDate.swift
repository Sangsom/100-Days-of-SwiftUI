//
//  Date+printFormattedDate.swift
//  Bookworm
//
//  Created by Rinalds Domanovs on 17/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import Foundation

extension Date {
    func printFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full

        return dateFormatter.string(from: self)
    }
}
