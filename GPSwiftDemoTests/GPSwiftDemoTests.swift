//
//  GPSwiftDemoTests.swift
//  GPSwiftDemoTests
//
//  
//

import XCTest

final class GPSwiftDemoTests: XCTestCase {

    func testFormattedLaunchDate_With_ValidDate() {
        let viewModel = MissionViewModel()
        
        // Test with a valid date
        let formattedDate = viewModel.formattedLaunchDate(launchDate: "2022-01-01T12:34:56.789Z")
        XCTAssertEqual(formattedDate, "1/1/22, 6:04 PM")
        
    }
    
    func testFormattedLaunchDate_With_InvalidDate() {
        
        let viewModel = MissionViewModel()
        // Test with an invalid date
        let invalidFormattedDate = viewModel.formattedLaunchDate(launchDate: "invalidDate")
        XCTAssertNil(invalidFormattedDate)
    }
    
    func testSortMissions() {
            let viewModel = MissionViewModel()

            // Create sample missions
            let mission1 = Mission(mission_name: "Mission 1", launch_date_utc: "2022-01-01T12:00:00.000Z", rocket: nil, links: nil, launch_site: nil)
            let mission2 = Mission(mission_name: "Mission 2", launch_date_utc: "2022-01-02T12:00:00.000Z", rocket: nil, links: nil, launch_site: nil)
            let mission3 = Mission(mission_name: "Mission 3", launch_date_utc: "2022-01-03T12:00:00.000Z", rocket: nil, links: nil, launch_site: nil)

            // Set up unsorted missionsArray
            viewModel.missionsArray = [mission2, mission1, mission3]

            // Call the sortMissions method
            viewModel.sortMissions()

            // Check if missionsArray is sorted
            XCTAssertEqual(viewModel.missionsArray, [mission3, mission2, mission1])
        }
    
    func testJsonResponse_of_GetMissionsAPI() {
        let servicemanager = ServiceManager()
        let expectation = XCTestExpectation(description: "API Call Completion")
        servicemanager.getMissions(completion: { missions in
            // Wait for the API call to complete

            DispatchQueue.main.async {
                XCTAssertEqual(missions.count, 111)
                XCTAssertEqual(missions[0].mission_name, "FalconSat")
                // You can add more assertions based on your actual data model and expectations
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 15.0)
    }
}
