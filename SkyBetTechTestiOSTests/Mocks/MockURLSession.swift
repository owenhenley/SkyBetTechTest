//
//  MockURLSession.swift
//  SkyBetTechTestiOSTests
//
//  Created by Owen Henley on 29/12/2020.
//

import XCTest
@testable import SkyBetTechTestiOS

class MockURLSession: URLSessionProtocol {
    var lastRequest: URLRequest?
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        defer {
            completionHandler(nil, nil, nil)
        }
        
        lastRequest = request
        let datatask = MockDataTask()
        return datatask
    }
}

class MockDataTask: URLSessionDataTask {
   override func resume() { }
}

