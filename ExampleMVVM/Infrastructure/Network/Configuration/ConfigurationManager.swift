//
//  AppConfiguration.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 20/6/24.
//

import Foundation

class AppConfiguration: ConfigurationProtocol {
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/forecast"
    }
    
    var apiKey: String {
        return "c8bea7fd8fb47ad823162954a2965e4b" // Replace with your actual API key
    }
    
    var localWeatherDataFilename: String {
        return "weather_data"
    }
}

