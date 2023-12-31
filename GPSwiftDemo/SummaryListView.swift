//
//  SummaryListView.swift
//  GPSwiftDemo
//
//  Created by AUI Tech on 29/12/23.
//


import SwiftUI

struct Mission: Identifiable {
    let id = UUID()
    var missionId: Int
    var missionName: String
    var rocketName: String
    var launchSiteName: String
    var dateOfLaunch: String
}

struct SummaryListView: View {
    let missions = [
        Mission(missionId: 1, missionName: "SpaceX1", rocketName: "Chandrayaan", launchSiteName: "Isro", dateOfLaunch: "23/11/2023"),
        Mission(missionId: 2, missionName: "SpaceX2", rocketName: "Chandrayaan2", launchSiteName: "Isro2", dateOfLaunch: "23/12/2023")]
    @State private var missionid: Mission.ID?
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            List(missions, selection: $missionid) { mission in
                HStack{
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(height:50)
                        .padding()
                    VStack(alignment: .leading,
                           spacing: 5){
                        Text(mission.missionName)
                            .fontWeight(.semibold)
                            .lineLimit(2)
                        Text(mission.dateOfLaunch)
                            .fontWeight(.regular)
                            .foregroundColor(.gray)
                    }
                }
                
            }.navigationTitle("Missions")
        } detail: {
            if let selectedID = missionid {
                let selectedMission = missions.filter(  { mission in
                    mission.id == selectedID
                }).first
                VStack(alignment: .leading,
                       spacing: 5){
                    Text("21 Jan 2023")
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                    Text(selectedMission?.missionName ?? "")
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                }
                       .navigationTitle("Mission Details")
            }else{
                Text("No selection")
                    .navigationTitle("Mission Details")
            }
            
        }
        
    }
    func getMissionsData() async throws -> MissionData{
        let endPoint = "https://api.spacexdata.com/v3/launches"
         
        guard let url = URL(string: endPoint ) else {
            throw MissionError.invalidURL
        }
                
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw MissionError.invalidResponse
        }
    }
}
struct MissionData: Codable {
    let mission_name : String
}

enum MissionError: Error {
    case invalidURL
    case invalidResponse
    
}

//struct SummaryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummaryListView()
//    }
//}
