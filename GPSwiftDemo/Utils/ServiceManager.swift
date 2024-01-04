//
//  ServiceManager.swift
//  GPSwiftDemo
//
//

import Foundation

class ServiceManager {
    
    //Get data from API
    func getMissions(completion: @escaping ([Mission]) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v3/launches") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            do {
                let missionArray = try JSONDecoder().decode([Mission].self, from: data)
                completion(missionArray)
            } catch {
                print(error)
                completion([])
            }
        }
        task.resume()
    }
}
