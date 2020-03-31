//
//  UserView.swift
//  Friend Face
//
//  Created by Rinalds Domanovs on 30/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct UserView: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var showingFriend = false
    @State private var selectedFriend: Friend?

    var user: User

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("person")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .background(self.colorScheme == .dark ? Color.green.opacity(0.4) : Color.black.opacity(0.4))
                    .clipShape(Circle())

                VStack(alignment: .leading) {
                    Text("\(user.name ?? "Unknown name"), Age")
                        .font(.title)
                        .foregroundColor(.primaryOrange)
                    Text("\(user.company ?? "Unknown company")")
                    Text(user.isActive ? "Active" : "Inactive")
                        .foregroundColor(user.isActive ? Color.green : Color.red)
                }

                Spacer()
            }.padding(.bottom)

//            HStack {
//                Image(systemName: "envelope").frame(width: 40)
//                    .foregroundColor(.primaryOrange)
//                Text("\(user.email)")
//            }
//
//            HStack {
//                Image(systemName: "mappin").frame(width: 40)
//                    .foregroundColor(.primaryOrange)
//                Text("\(user.address)")
//
//            }
//
//            Text("About Me")
//                .font(.title)
//                .foregroundColor(.primaryOrange)
//
//
//            Text("\(user.about)")
//
//            Text("Friends")
//                .font(.title)
//                .foregroundColor(.primaryOrange)
//
//            ScrollView(.horizontal, showsIndicators: true) {
//                HStack(spacing: 20) {
//                    ForEach(user.friends, id: \.id) { friend in
//                        NavigationLink(destination: FriendView(friend: friend)) {
//                            VStack {
//                                Image("person")
//                                    .resizable()
//                                    .frame(width: 80, height: 80)
//                                    .background(self.colorScheme == .dark ? Color.green.opacity(0.4) : Color.black.opacity(0.4))
//                                    .clipShape(Circle())
//                                Text(friend.name)
//                            }.frame(width: 120, height: 120)
//                        }.buttonStyle(PlainButtonStyle())
//                    }
//                }
//            }
//            Spacer()
        }
        .padding()
        .foregroundColor(.secondary)
        .onAppear {
//            self.usersController.selectedUser = self.user
        }
    }
}
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User())
    }
}

extension Color {
    static let primaryOrange = Color(UIColor.systemOrange)
}
