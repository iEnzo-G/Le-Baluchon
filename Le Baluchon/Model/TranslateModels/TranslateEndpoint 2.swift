//
//  TranslateEndpoint.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 25/09/2022.
//

import Foundation

enum TranslateEndpoint {
    case post(String)
    
    func urlRequest(baseURL: URL) -> URLRequest {
        switch self {
        case let .post(text):
            var request = URLRequest(url: baseURL)
            request.httpMethod = "POST"
            let body = "text=" + text + "&source_lang=FR&target_lang=EN"
            request.httpBody = body.data(using: .utf8)
            request.allHTTPHeaderFields = ["Authorization" : "DeepL-Auth-Key f419ed1c-47cd-33ac-fd74-cbff06750a2f:fx"]
            
            return request
        }
    }
}



    
