//
//  ExchangeRate.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import Foundation

struct Currency: Decodable {
    
}

class ExchangeRate {
    let amount = "1"
    init(amount: String) {
        self.amount = amount
    }
    static let url = URL(string: "https://api.apilayer.com/fixer/convert?to=USD&from=EUR&amount=\(amount)")!
    
    func getCurrency() {
    //var request = URLRequest(url: url, timeoutInterval: Double.infinity)
    request.httpMethod = "GET"
    request.addValue("Vxvy8dMQlAuKjbvNvkInyxUM6zpzz9JG", forHTTPHeaderField: "apikey")
    //
    //let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //  guard let data = data else {
    //    print(String(describing: error))
    //    return
    //  }
    //  print(String(data: data, encoding: .utf8)!)
    task.resume()
    }
    
    func getAmountToConvert() -> String {
        return "1"
    }
}

class ExchangeMapper {
    private init() {}
    
    static func map(data: Data, response: HTTPURLResponse) throws -> Currency {
        guard response.statusCode == 200, let currency = try? JSONDecoder().decode(Currency.self, from: data) else {
            throw NetworkError.undecodable
        }
        return currency
    }
}
