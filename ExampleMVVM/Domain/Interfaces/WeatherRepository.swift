//
//  WeatherRepository.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 19/6/24.
//

import SwiftUI

public protocol WeatherRepository {
    func fetchWeather(for city: String, completion: @escaping (Result<Forecast, Error>) -> Void)
}
