//
//  WeatherAPIConfiguration.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 19/6/24.
//

import Foundation

public class WeatherAPIConfiguration {
    private let configuration: ConfigurationProtocol
    
    init(configuration: ConfigurationProtocol) {
        self.configuration = configuration
    }
    
    func makeWeatherURL(for city: String) -> URL? {
        let baseURL = configuration.baseURL
        let apiKey = configuration.apiKey
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        return components?.url
    }
}


