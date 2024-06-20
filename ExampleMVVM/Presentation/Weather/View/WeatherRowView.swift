//
//  WeatherRowView.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 19/6/24.
//

import SwiftUI

struct WeatherRowView: View {
    let weather: Weather
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Date: \(Date(timeIntervalSince1970: weather.dateTime), formatter: DateFormatter.shortDate)")
            Text("Temperature: \(weather.temperature.current)°C")
            Text("Condition: \(weather.type.rawValue)")
        }
        .padding()
    }
}

