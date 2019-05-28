//
//  URLRequest+Ext.swift
//  SkyBetTechTestiOS
//
//  Created by Owen Henley on 28/05/2019.
//

import Foundation

extension URLRequest {

    enum HTTPMethod: String {
        case get = "GET"
        case head = "HEAD"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case connect = "CONNECT"
        case options = "OPTIONS"
        case trace = "TRACE"
        case patch = "PATCH"
    }

    var method: HTTPMethod? {
        get {
            guard let httpMethod = self.httpMethod else {
                return nil
            }

            let method = HTTPMethod(rawValue: httpMethod)
            return method
        }
        set {
            self.httpMethod = newValue?.rawValue
        }
    }

    init(url: URL, method: HTTPMethod, body: Data? = nil) {
        self.init(url: url)
        self.method = method
        self.httpBody = body
    }
}
