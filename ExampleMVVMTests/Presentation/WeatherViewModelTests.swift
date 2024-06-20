//
//  WeatherViewModelTests.swift
//  ExampleMVVMTests
//
//  Created by MacBook Air M1 on 20/6/24.
//

import XCTest
@testable import ExampleMVVM

class WeatherViewModelTests: XCTestCase {
    var weatherRepository: MockWeatherRepository!
    var fetchWeatherUseCase: FetchWeatherUseCase!
    var weatherViewModel: WeatherViewModel!

    override func setUp() {
        super.setUp()
        weatherRepository = MockWeatherRepository()
        fetchWeatherUseCase = FetchWeatherUseCase(repository: weatherRepository)
        weatherViewModel = WeatherViewModel(fetchWeatherUseCase: fetchWeatherUseCase)
    }

    override func tearDown() {
        weatherRepository = nil
        fetchWeatherUseCase = nil
        weatherViewModel = nil
        super.tearDown()
    }

    func testFetchWeatherSuccess() {
        let expectation = XCTestExpectation(description: "Fetch weather successfully")

        weatherViewModel.fetchWeather(for: "London")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(self.weatherViewModel.forecast)
            XCTAssertEqual(self.weatherViewModel.forecast?.city.name, "London")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchWeatherFailure() {
        weatherRepository.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch weather with error")

        weatherViewModel.fetchWeather(for: "London")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(self.weatherViewModel.errorMessage)
            XCTAssertEqual(self.weatherViewModel.errorMessage, "Test Error")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

