//
//  ExchangeRateController.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import UIKit

class ExchangeRateController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var EURAmountTextField: UITextField!
    @IBOutlet weak var USDAmountTextField: UITextField!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var getTheExchangeRateButton: UIButton!
    
    // MARK: - Properties
    
    
    let service = ExchangeRateLoader()
    let url = URL(string: "https://api.apilayer.com/fixer/latest?symbols=USD&base=EUR&apikey=Vxvy8dMQlAuKjbvNvkInyxUM6zpzz9JG")!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        newEntryInTextField()
//        service.load(url: url) { [weak self] result in
//            switch result {
//            case let .success(data):
//                print(data)
//                self?.getRates(response: data)
//                self?.convertEURToUSD(response: data)
//            case let .failure(error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    
    
    // MARK: - Actions
    
    @objc private func dismissKeyboard() {
        EURAmountTextField.resignFirstResponder()
    }
    
    @IBAction func tappedGetExchangeRateButton(_ sender: UIButton) {
        service.load(url: url) { [weak self] result in
            switch result {
            case let .success(data):
                print(data)
                self?.getRates(response: data)
                self?.convertEURToUSD(response: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

    // MARK: - Extension

extension ExchangeRateController: UpdateDelegate {
    func throwAlert(message: String) {
        
    }
    
    func updateScreen(calculText: String) {
        
    }
    
    
}
