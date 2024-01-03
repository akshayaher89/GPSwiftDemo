//
//  MissionCellView.swift
//  GPSwiftDemo
//
//  
//

import SwiftUI

struct MissionCellView: View {
    var mission : Mission
    var missionViewModel : MissionViewModel
    var body: some View {
        HStack{
            MissionIcon(url: mission.links?.mission_patch_small ?? "",width: 50, height: 50)
            VStack(alignment: .leading,
                   spacing: 5){
                Text(mission.mission_name)
                    .fontWeight(.bold)
                    .lineLimit(2)
                Text(mission.rocket?.rocket_name ?? "")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                Text(mission.launch_site?.site_name ?? "")
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                if let formattedDate = missionViewModel.formattedLaunchDate(launchDate: mission.launch_date_utc) {
                    Text(formattedDate)
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                }
                
            }
        }
        .tag(mission)
    }
}
