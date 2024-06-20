//
//  ExampleMVVMApp.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 19/6/24.
//

import SwiftUI

@main
struct ExampleMVVMApp: App {
    var body: some Scene {
        WindowGroup {
            let apiClient = APIClient()
            let appConfiguration = AppConfiguration()
            let apiConfiguration = WeatherAPIConfiguration(configuration: appConfiguration)
            let remoteDataSource = RemoteWeatherDataSource(apiClient: apiClient, apiConfiguration: apiConfiguration)
            
            let jsonLoader = JSONLoader()
            let localDataSource = LocalWeatherDataSource(jsonLoader: jsonLoader, configuration: appConfiguration)
            
            // Inject the appropriate data source
            let useLocalData = true // Change this to true to use local data
            let dataSource: WeatherDataSource = useLocalData ? localDataSource : remoteDataSource
            
            let repository = WeatherRepositoryImpl(dataSource: dataSource)
            let fetchWeatherUseCase = FetchWeatherUseCase(repository: repository)
            let viewModel = WeatherViewModel(fetchWeatherUseCase: fetchWeatherUseCase)
            
            WeatherView(viewModel: viewModel)
        }
    }
}


