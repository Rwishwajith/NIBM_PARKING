//
//  NIBM_ParkingTests.swift
//  NIBM ParkingTests
//

import XCTest
@testable import NIBM_Parking

class NIBM_ParkingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetAllSolts() throws {
        let controller = HomeController();
        controller.getAll() {(success) -> Void in
            
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
