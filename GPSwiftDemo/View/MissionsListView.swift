//
//  SummaryListView.swift
//  GPSwiftDemo
//
//  
//


import SwiftUI


struct MissionsListView: View {
    @StateObject var missionViewModel = MissionViewModel()
    @State private var selectedMission: Mission?

    //View creating with NavigationSpliView
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            List(selection: $selectedMission) {
                ForEach(missionViewModel.missionsArray, id: \.self){ mission in
                    MissionCellView(mission: mission, missionViewModel: missionViewModel)
                }
            }
            .navigationTitle("Missions")
            .onAppear{
                missionViewModel.getMission()
            }
        } detail:{
            if let selectedMission = selectedMission {
                MissionDetailView(selectedMission: selectedMission, missionViewModel: missionViewModel)
            }else {
                // Placeholder or default detail view content
                VStack(alignment: .leading, spacing: 20){
                    Text("Select a mission to view details")
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .frame(width: 200)
                }
            }
        }
    }
}

//struct SummaryListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MissionsListView()
//    }
//}



