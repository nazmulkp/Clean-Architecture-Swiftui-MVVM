//
//  WeatherView.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 19/6/24.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @State private var city: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter city", text: $city, onCommit: {
                    viewModel.fetchWeather(for: city)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                if let forecast = viewModel.forecast {
                    List {
                        ForEach(forecast.weatherBundle, id: \.dateTime) { weather in
                            WeatherRowView(weather: weather)
                        }
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    Text("Enter a city to get the weather forecast")
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Weather")
        }
    }
}



