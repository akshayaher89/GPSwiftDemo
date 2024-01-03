//
//  MissionData.swift
//  GPSwiftDemo
//
//  
//

import Foundation

struct Mission: Hashable, Codable {
    let mission_name: String
    let launch_date_utc: String
    let rocket: Rocket?
    let links: Links?
    let launch_site: LaunchSite?

    // Implement the hash(into:) method required by Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(mission_name)
        hasher.combine(launch_date_utc)
        hasher.combine(rocket)
        hasher.combine(links)
        hasher.combine(launch_site)
    }

    // Implement the == operator required by Equatable
    static func == (lhs: Mission, rhs: Mission) -> Bool {
        return lhs.mission_name == rhs.mission_name &&
        lhs.launch_date_utc == rhs.launch_date_utc &&
        lhs.rocket == rhs.rocket &&
        lhs.links == rhs.links &&
        lhs.launch_site == rhs.launch_site
    }
}
