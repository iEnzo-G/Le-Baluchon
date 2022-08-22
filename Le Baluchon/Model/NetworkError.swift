//
//  NetworkError.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 16/08/2022.
//

import Foundation

enum NetworkError: Error {
    case noData
    case invalidResponse
    case undecodableData
}

