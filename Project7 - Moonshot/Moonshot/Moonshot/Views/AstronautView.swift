//
//  AstronautView.swift
//  Moonshot
//
//  Created by Rinalds Domanovs on 28/02/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]

    init(astronaut: Astronaut) {
        self.astronaut = astronaut

        let loadMissions: [Mission] = Bundle.main.decode("missions.json")
        var matchMissions = [Mission]()

        for mission in loadMissions {
            if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                matchMissions.append(mission)
            }
        }

        self.missions = matchMissions
    }

    var body: some View {
        print(astronaut)
        return GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)

                    Group {
                        Text("Missions")
                            .font(.headline)

                        ForEach(self.missions, id: \.id) { mission in
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                Text(mission.formattedLaunchDate)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[3])
    }
}
