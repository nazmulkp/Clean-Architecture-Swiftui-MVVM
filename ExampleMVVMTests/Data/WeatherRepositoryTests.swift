//
//  WeatherRepositoryTests.swift
//  ExampleMVVMTests
//
//  Created by MacBook Air M1 on 20/6/24.
//

import XCTest
@testable import ExampleMVVM

class WeatherRepositoryTests: XCTestCase {
    var apiClient: MockAPIClient!
    var weatherRepository: WeatherRepositoryImpl!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        weatherRepository = WeatherRepositoryImpl(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        weatherRepository = nil
        super.tearDown()
    }

    func testFetchWeatherSuccess() {
        let expectation = XCTestExpectation(description: "Fetch weather successfully")

        weatherRepository.fetchWeather(for: "London") { result in
            switch result {
            case .success(let forecast):
                XCTAssertEqual(forecast.city.name, "London")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchWeatherFailure() {
        apiClient.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch weather with error")

        weatherRepository.fetchWeather(for: "London") { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Test Error")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

// Mock API Client
class MockAPIClient: APIClient {
    var shouldReturnError = false

    override func request<T>(url: URL, method: HTTPMethod, body: Data? = nil, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Test Error"])))
        } else {
            let forecast = Forecast(city: City(name: "London", country: "UK"), weatherBundle: [])
            completion(.success(forecast as! T))
        }
    }
}

