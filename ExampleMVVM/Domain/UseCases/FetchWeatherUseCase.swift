//
//  FetchWeatherUseCase.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 19/6/24.
//

import SwiftUI

public class FetchWeatherUseCase {
    private let repository: WeatherRepository
    
    public init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    public func execute(city: String, completion: @escaping (Result<Forecast, Error>) -> Void) {
        repository.fetchWeather(for: city, completion: completion)
    }
}
