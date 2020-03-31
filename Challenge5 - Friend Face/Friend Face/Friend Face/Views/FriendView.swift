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

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("person")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .background(self.colorScheme == .dark ? Color.green.opacity(0.4) : Color.black.opacity(0.4))
                    .clipShape(Circle())

                VStack(alignment: .leading) {
                    Text("Mame, 33")
                        .font(.title)
                        .foregroundColor(.primaryOrange)
                    Text("Company")
                    Text(true ? "Active" : "Inactive")
                        .foregroundColor(true ? Color.green : Color.red)
                }

                Spacer()
            }.padding(.bottom)

            HStack {
                Image(systemName: "envelope").frame(width: 40)
                    .foregroundColor(.primaryOrange)
                Text("Email")
            }

            HStack {
                Image(systemName: "mappin").frame(width: 40)
                    .foregroundColor(.primaryOrange)
                Text("Address")

            }

            Text("About Me")
                .font(.title)
                .foregroundColor(.primaryOrange)


            Text("About")

            Spacer()
        }
        .padding()
        .foregroundColor(.secondary)
    }
}

struct FriendView_Previews: PreviewProvider {
    static var previews: some View {
        FriendView(friend: Friend())
    }
}
