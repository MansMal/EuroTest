//
//  EuroTestTests.swift
//  EuroTestTests
//
//  Created by Malek Mansour on 15/05/2023.
//

import XCTest
@testable import EuroTest

final class EuroTestTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIResponse() throws {
        let service: DataSourceContract = ListViewModel(for: true)
        XCTAssertEqual(service.dataList.videos.count, 4)
        XCTAssertEqual(service.dataList.stories.count, 11)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
