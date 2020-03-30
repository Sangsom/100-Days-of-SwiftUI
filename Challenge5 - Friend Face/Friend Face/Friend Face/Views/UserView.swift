//
//  UserView.swift
//  Friend Face
//
//  Created by Rinalds Domanovs on 30/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct UserView: View {
    @State private var showingFriend = false
    @State private var selectedFriend: Friend?

    var user: User

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("person")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .background(Color.black.opacity(0.4))
                    .clipShape(Circle())

                VStack(alignment: .leading) {
                    Text("\(user.name), \(user.age)")
                        .font(.title)
                        .foregroundColor(.primaryOrange)
                    Text(user.company)
                    Text(user.isActive ? "Active" : "Inactive")
                        .foregroundColor(user.isActive ? Color.green : Color.red)
                }

                Spacer()
            }.padding(.bottom)

            HStack {
                Image(systemName: "envelope").frame(width: 40)
                    .foregroundColor(.primaryOrange)
                Text(user.email)
            }

            HStack {
                Image(systemName: "mappin").frame(width: 40)
                    .foregroundColor(.primaryOrange)
                Text(user.address)

            }

            Text("About Me")
                .font(.title)
                .foregroundColor(.primaryOrange)


            Text(user.about)

            Text("Friends")
                .font(.title)
                .foregroundColor(.primaryOrange)

            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 20) {
                    ForEach(user.friends) { friend in
                        NavigationLink(destination: FriendView(friend: friend)) {
                            VStack {
                                Image("person")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .background(Color.black.opacity(0.4))
                                    .clipShape(Circle())
                                Text(friend.name)
                            }.frame(width: 120, height: 120)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
            Spacer()
        }
        .padding()
        .foregroundColor(.secondary)
    }
}
struct UserView_Previews: PreviewProvider {
    static let user = User(id: "1", isActive: true, name: "Rinalds Domanovs", age: 31, company: "Apple", email: "rinalds.domanovs@gmail.com", address: "Mazcenu Aleja 20C-9", about: "Self-thaught iOS Developer", registered: "05.03.2020", tags: ["ios", "swift"], friends: [Friend(id: "5", name: "Ivars Kims"), Friend(id: "9", name: "Teodors Domanovs")])
    static var previews: some View {
        UserView(user: user)
    }
}

extension Color {
    static let primaryOrange = Color(UIColor.systemOrange)
}
