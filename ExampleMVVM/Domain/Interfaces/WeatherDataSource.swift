//
//  WeatherDataSource.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 20/6/24.
//

import Foundation

public protocol WeatherDataSource {
    func fetchWeather(for city: String, completion: @escaping (Result<Forecast, Error>) -> Void)
}

