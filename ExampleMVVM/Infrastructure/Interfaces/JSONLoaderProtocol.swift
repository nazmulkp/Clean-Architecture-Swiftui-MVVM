//
//  JSONLoaderProtocol.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 20/6/24.
//

import Foundation

public protocol JSONLoaderProtocol {
    func loadJSON(filename: String) -> Data?
}

