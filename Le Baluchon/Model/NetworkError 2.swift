//
//  NetworkError.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 16/08/2022.
//

import Foundation

// Private error information for the developper to find where is localized error between App and the API.
enum NetworkError: Error {
    case noData
    case invalidResponse
    case undecodableData
}
