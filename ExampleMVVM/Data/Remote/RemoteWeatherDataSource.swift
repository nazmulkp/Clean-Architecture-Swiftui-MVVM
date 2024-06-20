//
//  RemoteWeatherDataSource.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 20/6/24.
//

import Foundation

import Foundation

public class RemoteWeatherDataSource: WeatherDataSource {
    private let apiClient: APIClientProtocol
    private let apiConfiguration: WeatherAPIConfiguration
    
    public init(apiClient: APIClientProtocol, apiConfiguration: WeatherAPIConfiguration) {
        self.apiClient = apiClient
        self.apiConfiguration = apiConfiguration
    }
    
    public func fetchWeather(for city: String, completion: @escaping (Result<Forecast, Error>) -> Void) {
        guard let url = apiConfiguration.makeWeatherURL(for: city) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        apiClient.request(url: url, method: .get, completion: completion)
    }
}


