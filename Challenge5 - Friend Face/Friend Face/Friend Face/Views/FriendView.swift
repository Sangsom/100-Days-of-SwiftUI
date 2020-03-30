//
//  FriendView.swift
//  Friend Face
//
//  Created by Rinalds Domanovs on 30/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct FriendView: View {
    @Environment(\.colorScheme) var colorScheme

    var friend: Friend
    var usersController: UserController

    var selectedFriend: User {
        return usersController.users.first(where: { $0.id == friend.id})!
    }

    init(friend: Friend, usersController: UserController) {
        self.friend = friend
        self.usersController = usersController
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("person")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .background(self.colorScheme == .dark ? Color.green.opacity(0.4) : Color.black.opacity(0.4))
                    .clipShape(Circle())

                VStack(alignment: .leading) {
                    Text("\(selectedFriend.name), \(selectedFriend.age)")
                        .font(.title)
                        .foregroundColor(.primaryOrange)
                    Text(selectedFriend.company)
                    Text(selectedFriend.isActive ? "Active" : "Inactive")
                        .foregroundColor(selectedFriend.isActive ? Color.green : Color.red)
                }

                Spacer()
            }.padding(.bottom)

            HStack {
                Image(systemName: "envelope").frame(width: 40)
                    .foregroundColor(.primaryOrange)
                Text(selectedFriend.email)
            }

            HStack {
                Image(systemName: "mappin").frame(width: 40)
                    .foregroundColor(.primaryOrange)
                Text(selectedFriend.address)

            }

            Text("About Me")
                .font(.title)
                .foregroundColor(.primaryOrange)


            Text(selectedFriend.about)

            Spacer()
        }
        .padding()
        .foregroundColor(.secondary)
    }
}

struct FriendView_Previews: PreviewProvider {
    static let friend = Friend(id: "02460e65-d28c-4389-87d0-b61a74140922", name: "Berg Donovan")

    static var previews: some View {
        FriendView(friend: friend, usersController: UserController())
    }
}
