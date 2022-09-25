//
//  ExchangeRateController.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import UIKit

final class ExchangeRateController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var amountEURTextField: CustomUITextField!
    @IBOutlet weak var amountUSDTextField: UITextField!
    @IBOutlet weak var rateLabel: UILabel!
    
    // MARK: - Properties
    
    private let loader = FixerLoader()
    private var rate: Double = 0.0
    
    private var finalCurrency = "USD"
    private var startingCurrency = "EUR"
    
    private var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        return formatter
    }()
    
    // MARK: - View life cycle) 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
//        loadExchangeRate()
    }
    
    // MARK: - Actions
    
    func updateRate(updateRate: Double) {
        guard let rateFormatter = formatter.string(for: updateRate) else { return }
        rateLabel.text! = "Rate: " + rateFormatter
    }
    
    private func loadExchangeRate() {
        loader.load(to: finalCurrency, from: startingCurrency) { [weak self] result in
            switch result {
            case let .success(rate):
                guard let updatedRate = rate.rates[self!.finalCurrency] else { return }
                self?.rate = updatedRate
                self?.updateRate(updateRate: updatedRate)
            case .failure(_):
                self?.presentAlert(message: "Something happened wrong from the API. Please try later.")
            }
        }
    }
    
    func convertEURToUSD() {
        guard amountEURTextField.text! != "00" else {
            presentAlert(message: "Please enter a correct amount to convert.")
            return
        }
        guard let amountEUR = Double(amountEURTextField.text!) else { return }
        guard let result = formatter.string(for: amountEUR * rate) else { return }
        amountUSDTextField.text = result
    }
    
    @IBAction func typedInEURTextField(_ sender: UITextField) {
        var dotCount = 0
        for (_, dot) in amountEURTextField.text!.enumerated() {
            if dot == "." {
                dotCount += 1
            }
            if dotCount > 1 {
                amountEURTextField.text?.removeLast()
            }
        }
        convertEURToUSD()
    }
    
    @IBAction func tappedAmountEURTextField(_ sender: UITextField) {
        amountEURTextField.text = ""
    }
    
    @objc private func dismissKeyboard() {
        amountEURTextField.resignFirstResponder()
    }
}
