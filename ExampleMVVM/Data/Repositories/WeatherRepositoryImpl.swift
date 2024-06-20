//
//  WeatherRepositoryImpl.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 19/6/24.
//

import Foundation

public class WeatherRepositoryImpl: WeatherRepository {
    private let dataSource: WeatherDataSource
    
    public init(dataSource: WeatherDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetchWeather(for city: String, completion: @escaping (Result<Forecast, Error>) -> Void) {
        dataSource.fetchWeather(for: city, completion: completion)
    }
}

