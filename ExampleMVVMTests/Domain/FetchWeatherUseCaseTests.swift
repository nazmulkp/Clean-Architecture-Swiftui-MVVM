//
//  FetchWeatherUseCaseTests.swift
//  ExampleMVVMTests
//
//  Created by MacBook Air M1 on 20/6/24.
//

import XCTest
@testable import ExampleMVVM

class FetchWeatherUseCaseTests: XCTestCase {
    var weatherRepository: MockWeatherRepository!
    var fetchWeatherUseCase: FetchWeatherUseCase!

    override func setUp() {
        super.setUp()
        weatherRepository = MockWeatherRepository()
        fetchWeatherUseCase = FetchWeatherUseCase(repository: weatherRepository)
    }

    override func tearDown() {
        weatherRepository = nil
        fetchWeatherUseCase = nil
        super.tearDown()
    }

    func testExecuteSuccess() {
        let expectation = XCTestExpectation(description: "Fetch weather successfully")

        fetchWeatherUseCase.execute(city: "London") { result in
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

    func testExecuteFailure() {
        weatherRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch weather with error")

        fetchWeatherUseCase.execute(city: "London") { result in
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

// Mock Weather Repository
class MockWeatherRepository: WeatherRepository {
    var shouldReturnError = false

    func fetchWeather(for city: String, completion: @escaping (Result<Forecast, Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Test Error"])))
        } else {
            let forecast = Forecast(city: City(name: "London", country: "UK"), weatherBundle: [])
            completion(.success(forecast))
        }
    }

    func updateWeather(for city: String, with data: Data, completion: @escaping (Result<Void, Error>) -> Void) {
        // Not needed for this test
    }

    func deleteWeather(for city: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Not needed for this test
    }
}

