//
//  ExchangeRateController.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    let service = URLSessionHTTPClient()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.get(url: ExchangeRate.url) { result in
            switch result {
            case let .success(currency):
                print(currency)
            case let .failure(error):
                print(error)
            }
        }
    }

}
