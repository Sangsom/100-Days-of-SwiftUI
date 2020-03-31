//
//  Friend+CoreDataProperties.swift
//  Friend Face
//
//  Created by Rinalds Domanovs on 31/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
