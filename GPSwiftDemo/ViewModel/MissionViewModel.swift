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
    
    //date formatter for UTC Launch date
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    //function to convert UTC launch date into readable format
    func formattedLaunchDate(launchDate : String?) -> String? {
        guard let launchDateUTC = launchDate,
              let date = dateFormatter.date(from: launchDateUTC) else {
            return nil
        }
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .short)
    }
    
    // Sort missionsArray based on launch_date_utc
    func sortMissions() {
        self.missionsArray.sort { mission1, mission2 in
            guard let date1 = dateFormatter.date(from: mission1.launch_date_utc), let date2 = dateFormatter.date(from: mission2.launch_date_utc) else {
                return false
            }
            return date1 > date2
        }
    }
    
    //Get mission data from API
    func getMission(){
        serviceManager.getMissions { [weak self] missions in
            DispatchQueue.main.async {
                self?.missionsArray = missions
                self?.sortMissions()
            }
        }
    }
}
