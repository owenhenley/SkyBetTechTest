//
//  NetworkControllerTests.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 17/12/2020.
//

import XCTest
@testable import SkyBetTechTestiOS

class URLSessionMock: URLSessionProtocol {
    var lastRequest: URLRequest?
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        defer {
            completionHandler(nil, nil, nil)
        }
        
        lastRequest = request
        let datatask = DataTaskMock()
        return datatask
    }
}

class DataTaskMock: URLSessionDataTask {
   override func resume() { }
}

class NetworkControllerTests: XCTestCase {
    var session: URLSessionMock!
    var sut: NetworkController!
    
    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        sut = NetworkController()
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
