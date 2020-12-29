//
//  HorseRacesServiceTests.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 17/12/2020.
//

import XCTest
@testable import SkyBetTechTestiOS

class HorseRacesServiceTests: XCTestCase {
    
    var session: MockURLSession!
    var sut: HorseRacesService!
    
    override func setUp() {
        super.setUp()
        session = MockURLSession()
        sut = HorseRacesService()
    }
    
    override func tearDown() {
        session = nil
        sut = nil
        super.tearDown()
    }
    
    func testFetchingCorrectRaces() {
        guard let expectedFinalURL = URL(string: "https://raw.githubusercontent.com/owenhenley/SkyBetTechTest/main/techtest.json") else {
            XCTFail()
            return
        }
        let expectation = XCTestExpectation(description: "fetching races")
        
        sut.fetchRaces(using: session) { _, _ in
            XCTAssertEqual(URLRequest(url: expectedFinalURL), self.session.lastRequest)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
