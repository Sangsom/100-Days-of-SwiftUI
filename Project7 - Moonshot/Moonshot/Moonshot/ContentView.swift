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
                        if self.showingNames {
                            VStack {
                                MissionNames(mission: mission)
                            }
                        } else {
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(showingNames ? "Show Dates" : "Show Names") {
                self.showingNames.toggle()
            })
        }
    }
}

struct MissionNames: View {
    var mission: Mission
    var astronauts: [Astronaut]

    init(mission: Mission) {
        self.mission = mission

        let loadAstronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
        var matchAstronauts = [Astronaut]()

        for astronaut in loadAstronauts {
            if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                matchAstronauts.append(astronaut)
            }
        }

        self.astronauts = matchAstronauts
    }

    var body: some View {
        ForEach(self.astronauts, id: \.id) {
            Text("\($0.name)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
