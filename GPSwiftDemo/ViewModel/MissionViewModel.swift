//
//  MissionViewModel.swift
//  GPSwiftDemo
//
//  
//

import Foundation
import SwiftUI

class MissionViewModel : ObservableObject {
    @Published var missionsArray : [Mission] = []
    private let serviceManager = ServiceManager()

    
    private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            return formatter
        }()
    
    func formattedLaunchDate(launchDate : String?) -> String? {
        guard let launchDateUTC = launchDate,
              let date = dateFormatter.date(from: launchDateUTC) else {
            return nil
        }
        
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .short)
    }
    
    func sortMissions() {
            // Sort missionsArray based on launch_date_utc
        self.missionsArray.sort { mission1, mission2 in
                guard let date1 = dateFormatter.date(from: mission1.launch_date_utc), let date2 = dateFormatter.date(from: mission2.launch_date_utc) else {
                    return false
                }
                return date1 > date2
            }
        }
    
//    func getMissionsDataVM(){
//        guard let url = URL(string: "https://api.spacexdata.com/v3/launches") else{
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let data = data, error == nil else {
//                return
//            }
//
//            do{
//                let missionArray = try JSONDecoder().decode([Mission].self, from: data)
//
//                DispatchQueue.main.async {
//                    self?.missionsArray = missionArray
//                    self?.sortMissions()
//                }
//            }
//            catch{
//                print(error)
//            }
//        }
//        task.resume()
//    }
    func getMission(){
        serviceManager.getMissions { [weak self] missions in
            DispatchQueue.main.async {
                self?.missionsArray = missions
                self?.sortMissions()
            }
        }
    }
}
