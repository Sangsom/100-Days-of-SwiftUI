//
//  ContentView.swift
//  Moonshot
//
//  Created by Rinalds Domanovs on 27/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingNames = false

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.systemOrange,
            .font : UIFont(name:"Rockwell", size: 40)!]
    }

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                            .foregroundColor(Color(UIColor.systemOrange))
                        if self.showingNames {
                            VStack {
                                MissionNames(mission: mission)
                            }
                        } else {
                            Text(mission.formattedLaunchDate)
                                .foregroundColor(Color(UIColor.systemGray))
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Toggle(isOn: $showingNames) {
                Text("Toggle \(showingNames ? "dates" : "astronauts")")
                    .foregroundColor(Color(UIColor.systemGray))
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
