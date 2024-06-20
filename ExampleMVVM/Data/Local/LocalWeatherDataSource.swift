//
//  LocalWeatherDataSource.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 20/6/24.
//

import Foundation

public class LocalWeatherDataSource: WeatherDataSource {
    private let jsonLoader: JSONLoaderProtocol
    private let configuration: ConfigurationProtocol
    
    public init(jsonLoader: JSONLoaderProtocol, configuration: ConfigurationProtocol) {
        self.jsonLoader = jsonLoader
        self.configuration = configuration
    }
    
    public func fetchWeather(for city: String, completion: @escaping (Result<Forecast, Error>) -> Void) {
        let filename = configuration.localWeatherDataFilename
        if let data = jsonLoader.loadJSON(filename: filename) {
            do {
                let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                print(forecast)
                completion(.success(forecast))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load local data"])))
        }
    }
}



