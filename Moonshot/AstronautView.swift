//
//  AstronautView.swift
//  Moonshot
//
//  Created by 최준영 on 2022/11/28.
//

import SwiftUI

struct AstronautView: View {
    var astronaut: Astronaut
    @ObservedObject var jsonData: JSONData
    var missions: [Mission]
    
    init(astronaut: Astronaut, jsonData: JSONData) {
        self.astronaut = astronaut
        self.jsonData = jsonData
        //searching joined mission
        self.missions = jsonData.missions.filter {
            mission in
            mission.crew.contains { crew in
                crew.name == astronaut.id
            }
        }
        
    }
    
    var body: some View {
        ZStack {
            Color.darkBackground
                .ignoresSafeArea()
            ScrollView {
                VStack {
                    Image(decorative: astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            Rectangle()
                                .strokeBorder(.linearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.5)
    
                        }
                        .padding(.top, 5)
                    Text(astronaut.name)
                        .font(.headline.bold())
                        .padding(.top, 5)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.lightBackground)
                        .padding([.top, .bottom], 3)
                    Text(astronaut.description)
                        .padding(.horizontal)
                }
                .padding(.bottom, 5)
                HStack {
                    Text("Missions")
                        .font(.title2.bold())
                        .padding(.leading, 20)
                    Spacer()
                }
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.lightBackground)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, jsonData)
                            } label: {
                                VStack {
                                    Image(mission.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 100)
                                        .padding(.top, 10)
                                    VStack {
                                        Text(mission.displayName)
                                            .font(.caption)
                                            .foregroundColor(.yellow)
                                    }
                                    .frame(width: 100,height: 30)
                                    .background(.lightBackground)
                                }
                                .frame(width: 100, height: 140)
                                .padding(.bottom, 5)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(.lightBackground, lineWidth: 2)
                                }
                            }
                        }
                    }
                    .padding(.leading, 15)
                }
                .navigationTitle(astronaut.id)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var jsonData = JSONData()
    static var astro: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astro["grissom"]!, jsonData: jsonData)
            .preferredColorScheme(.dark)
    }
}
