//
//  APIClientProtocol.swift
//  ExampleMVVM
//
//  Created by MacBook Air M1 on 20/6/24.
//

import Foundation

public protocol APIClientProtocol {
    func request<T: Decodable>(url: URL, method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void)
}
