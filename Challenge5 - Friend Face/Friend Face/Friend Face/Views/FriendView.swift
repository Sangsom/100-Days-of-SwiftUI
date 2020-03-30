//
//  FriendView.swift
//  Friend Face
//
//  Created by Rinalds Domanovs on 30/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct FriendView: View {
    @State private var user: User?
    var friend: Friend

    init(friend: Friend) {
        self.friend = friend
    }

    var body: some View {
        Text(friend.name)
    }
}

struct FriendView_Previews: PreviewProvider {
    static let friend = Friend(id: "5", name: "Ivars Kims")

    static var previews: some View {
        FriendView(friend: friend)
    }
}
