//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Rinalds Domanovs on 03/04/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }

        set {
            title = newValue
        }
    }

    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}
