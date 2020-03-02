//
//  MissionNames.swift
//  Moonshot
//
//  Created by Rinalds Domanovs on 02/03/2020.
//  Copyright © 2020 Rinalds Domanovs. All rights reserved.
//

import SwiftUI

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
        VStack(alignment: .leading) {
            ForEach(self.astronauts, id: \.id) {
                    Text("\($0.name)")
            }
        }
        .font(.subheadline)
        .foregroundColor(Color(UIColor.systemGray))
    }
}

struct MissionNames_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        MissionNames(mission: missions[0])
    }
}
