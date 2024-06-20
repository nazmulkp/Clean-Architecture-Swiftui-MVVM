//
//  WeatherViewModel.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 19/6/24.
//

import Foundation
import Combine

public class WeatherViewModel: ObservableObject {
    private let fetchWeatherUseCase: FetchWeatherUseCase
    @Published var forecast: Forecast?
    @Published var errorMessage: String?
    
    public init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }
    
    public func fetchWeather(for city: String) {
        fetchWeatherUseCase.execute(city: city) { [weak self] result in
            switch result {
            case .success(let forecast):
                DispatchQueue.main.async {
                    self?.forecast = forecast
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
