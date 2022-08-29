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
        
        EURAmountTextField.addGestureRecognizer(gestureRecognizer())
        
        service.load(url: url) { result in
            switch result {
            case let .success(data):
                print(data)
                self.getRates(response: data)
                self.convertEURToUSD(response: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    
    // MARK: - Actions
    
    private func gestureRecognizer() -> UIGestureRecognizer {
        let gesture = UIGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        return gesture
    }
    
    @objc private func dismissKeyboard() {
        EURAmountTextField.resignFirstResponder()
    }
    
    private func getRates(response: FixerResponse){
        
        let rates = String(format:"%f", response.rates["USD"]!)
        rateLabel.text = "Rate: " + rates
    }
    
    private func convertEURToUSD(response: FixerResponse) {
        guard let rate: Double = response.rates["USD"] else {
            return
        }
        
        let amountEUR = Double(EURAmountTextField.text!) ?? 1.00
        USDAmountTextField.text = String(amountEUR * rate)
    }
    
    private func newEntryInTextField() {
       if EURAmountTextField.isTouchInside {
            EURAmountTextField.text = ""
        }
    }
    
    @IBAction func tappedGetExchangeRateButton(_ sender: UIButton) {
        service.load(url: url) { result in
            switch result {
            case let .success(data):
                print(data)
                self.getRates(response: data)
                self.convertEURToUSD(response: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
