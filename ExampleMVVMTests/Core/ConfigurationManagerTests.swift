//
//  ConfigurationManagerTests.swift
//  ExampleMVVMTests
//
//  Created by MacBook Air M1 on 20/6/24.
//

import XCTest
@testable import ExampleMVVM

class ConfigurationManagerTests: XCTestCase {
    func testConfigurationManagerLoadsValues() {
        let configurationManager = ConfigurationManager.shared
        
        XCTAssertNotNil(configurationManager.baseURL)
        XCTAssertNotNil(configurationManager.apiKey)
        XCTAssertEqual(configurationManager.baseURL, "https://api.openweathermap.org/data/2.5/forecast")
        XCTAssertEqual(configurationManager.apiKey, "your_api_key") // replace with your actual key for testing
    }
}
