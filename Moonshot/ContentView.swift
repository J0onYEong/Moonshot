//
//  ContentView.swift
//  Moonshot
//
//  Created by 최준영 on 2022/11/23.
//

import SwiftUI

class JSONData: ObservableObject {
    var missions: [Mission] = Bundle.main.decode("missions.json")
    var astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
}
struct ContentView: View {
    @StateObject var jsonData = JSONData()
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(jsonData.missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, jsonData)
                        } label: {
                            VStack {
                                Image(mission.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                    Text(mission.formattedLanchDate)
                                        .font(.caption)
                                        .opacity(0.7)
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                                .foregroundColor(.white)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
