//
//  ExchangeRateController.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import UIKit

class ExchangeRateController: UIViewController {
    
    // MARK: - Outlets
    
    

    // MARK: - Properties
    
    let service = ExchangeRateLoader()
    let url = URL(string: "https://api.apilayer.com/fixer/latest?symbols=USD&base=EUR&apikey=Vxvy8dMQlAuKjbvNvkInyxUM6zpzz9JG")!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.load(url: url) { result in
            switch result {
            case let .success(data):
                print(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }

    }

}

    // MARK: - Actions
