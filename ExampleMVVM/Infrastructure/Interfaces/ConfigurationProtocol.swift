//
//  ConfigurationProtocol.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 20/6/24.
//

import Foundation

public protocol ConfigurationProtocol {
    var baseURL: String { get }
    var apiKey: String { get }
    var localWeatherDataFilename: String { get }
}

