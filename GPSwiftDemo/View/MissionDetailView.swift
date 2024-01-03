//
//  MissionDetailView.swift
//  GPSwiftDemo
//
//  
//

import SwiftUI


struct MissionDetailView: View {
    var selectedMission: Mission
    var missionViewModel: MissionViewModel
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white,.gray]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20.0){
                MissionIcon(url: selectedMission.links?.mission_patch_small ?? "", width: 120, height: 120)
                VStack(alignment: .leading, spacing: 20){
                    Text("Mission: \(selectedMission.mission_name)")
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .font(.system(size: 20))
                    Text("Rocket: \(selectedMission.rocket?.rocket_name ?? "")")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                    Text("Launch Site:\(selectedMission.launch_site?.site_name ?? "")")
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                        .font(.system(size: 18))
                    if let formattedDate = missionViewModel.formattedLaunchDate(launchDate: selectedMission.launch_date_utc) {
                        Text("Date of Launch:\(formattedDate)")
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    }
                    
                }
                
            }
            .padding()
            Spacer()
        }
    }
}
