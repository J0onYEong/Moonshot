//
//  MissionView.swift
//  Moonshot
//
//  Created by 최준영 on 2022/11/27.
//

import SwiftUI

struct MissionView: View {
    //merging struct
    //role from missions.json
    //astronaut from astronauts.json
    struct CrewMember {
        var role: String
        var astronaut: Astronaut
    }
    @ObservedObject var jsonData: JSONData
    var mission: Mission
    var crewMembers: [CrewMember]
    
    init(mission: Mission, _ jsonData: JSONData) {
        self.jsonData = jsonData
        self.mission = mission
        self.crewMembers = mission.crew.map { crew in
            if let astronaut = jsonData.astronauts[crew.name] {
                //merging
                return CrewMember(role: crew.role, astronaut: astronaut)
            } else {
                fatalError("missing \(crew.name)")
            }
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(mission.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width*0.6)
                        .padding(.top)
                    Text(mission.formattedLanchDate)
                        .font(.caption)
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.top, 5)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                    Text(mission.description)
                        .padding(.horizontal)
                }
                .padding(.bottom, 10)
                Text("Crew")
                    .font(.title.bold())
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.lightBackground)
                    .padding(.bottom, 5)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crewMembers, id: \.role) { member in
                            NavigationLink {
                                AstronautView(astronaut: member.astronaut, jsonData: jsonData)
                            } label: {
                                HStack {
                                    Image(member.astronaut.id)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 104, height: 72)
                                        .clipShape(Capsule())
                                        .overlay {
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        }
                                    VStack(alignment: .leading) {
                                        Text(member.astronaut.name)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Text(member.role)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_previews: PreviewProvider {
    static var jsonData = JSONData()
    static var previews: some View {
        MissionView(mission: jsonData.missions[0], jsonData)
            .preferredColorScheme(.dark)
    }
}
