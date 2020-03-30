//
//  ContentView.swift
//  Friend Face
//
//  Created by Rinalds Domanovs on 23/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

class UserController: ObservableObject {
    @Published var users = [User]()
    @Published var selectedUser: User?
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var usersController = UserController()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.systemOrange
        ]
    }

    var body: some View {
        NavigationView {
            List(usersController.users) { user in
                NavigationLink(destination: UserView(user: user, usersController: self.usersController)) {
                    HStack {
                        Image("person")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .background(self.colorScheme == .dark ?
                            Color.green.opacity(0.4) :
                            Color.black.opacity(0.4))
                        .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text("\(user.name)")
                                .foregroundColor(.secondary)
                            Text("\(user.age)")
                                .foregroundColor(.primaryOrange).opacity(0.8)
                        }
                    }
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
                    // Find particular friend
                    print(decodedResponse.first(where: { $0.name == "Russo Carlson"})!)
                    DispatchQueue.main.async {
                        self.usersController.users = decodedResponse
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
