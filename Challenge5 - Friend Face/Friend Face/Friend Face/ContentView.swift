//
//  ContentView.swift
//  Friend Face
//
//  Created by Rinalds Domanovs on 23/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct UserView: View {
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
                    Text(user.company)
                }

                Spacer()
            }.padding(.bottom)

            HStack {
                Image(systemName: "envelope").frame(width: 40)
                Text(user.email)
            }

            HStack {
                Image(systemName: "mappin").frame(width: 40)
                Text(user.address)
            }

            Text("About Me")
                .font(.title)

            Text(user.about)

            Text("Friends")
                .font(.title)

            ScrollView(.horizontal, showsIndicators: true) {
                HStack(spacing: 20) {
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                            .frame(width: 120, height: 120, alignment: .bottomLeading)
                            .background(
                                Color.green
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                            )

                    }
                }

            }
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView: View {
    @State private var users = [User]()

    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: UserView(user: user)) {
                    Text("\(user.name)")
                }
            }
            .navigationBarTitle(Text("Friend Face"))
        }
        .onAppear(perform: loadData)
    }

    func loadData() {
        print("Printing")
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {

                    DispatchQueue.main.async {
                        self.users = decodedResponse
                    }
                }

                return
            }

            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
