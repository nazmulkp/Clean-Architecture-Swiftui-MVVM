//
//  APIClientTests.swift
//  ExampleMVVMTests
//
//  Created by MacBook Air M1 on 20/6/24.
//

import XCTest
@testable import ExampleMVVM

class APIClientTests: XCTestCase {
    var apiClient: APIClient!

    override func setUp() {
        super.setUp()
        apiClient = APIClient(session: URLSessionMock())
    }

    override func tearDown() {
        apiClient = nil
        super.tearDown()
    }

    func testRequestSuccess() {
        // Add your test cases here
    }

    func testRequestFailure() {
        // Add your test cases here
    }
}

// Mock URLSession
class URLSessionMock: URLSession {
    var cachedUrl: URL?
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.cachedUrl = url
        self.completionHandler = completionHandler
        return URLSessionDataTaskMock()
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    override func resume() {
        // do nothing
    }
}

