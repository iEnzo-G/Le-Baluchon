//
//  ExchangeRateController.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import UIKit

class ExchangeRateController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var getCurrencyButton: UIButton!

    // MARK: - Properties
    
    let service = ExchangeRate()
    let url = URL(string: "https://api.apilayer.com/fixer/convert?to=USD&from=EUR&amount=" + ExchangeRate.amount)!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getCurrency(url: url) { result in
            switch result {
            case let .success(currency):
                print(currency)
            case let .failure(error):
                print(error)
            }
        }
        
//        service.get(url: ExchangeRate.url) { result in
//            switch result {
//            case let .success(currency):
//                print(currency)
//            case let .failure(error):
//                print(error)
//            }
//        }
    }
    
    @IBAction func tappedGetCurrencyButton(_ sender: UIButton) {
        service.getCurrency(url: url) { result in
            switch result {
            case let .success(currency):
                print(currency)
            case let .failure(error):
                print(error)
            }
        }
    }
   


}
