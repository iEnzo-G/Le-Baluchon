//
//  ExchangeRateController.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import UIKit

class ExchangeRateController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var amountEURTextField: CustomUITextField!
    @IBOutlet weak var amountUSDTextField: UITextField!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var getTheExchangeRateButton: UIButton!
    
    // MARK: - Properties
    
    private let exchangeRate = ExchangeRate()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        exchangeRate.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
//        exchangeRate.getExchangeRate()
    }
    
    
    
    // MARK: - Actions
    
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
        guard let eurAmount = amountEURTextField.text else { return }
        exchangeRate.eurAmountText = eurAmount
    }
    
    @IBAction func tappedAmountEURTextField(_ sender: UITextField) {
        amountEURTextField.text = ""
    }
    
    @objc private func dismissKeyboard() {
        amountEURTextField.resignFirstResponder()
    }
    
    @IBAction func tappedGetExchangeRateButton(_ sender: UIButton) {
        exchangeRate.getExchangeRate()
    }
}

    // MARK: - Extension

extension ExchangeRateController: UpdateDelegate {
    func updateUSDAmount(usd: String) {
        amountUSDTextField.text = usd
    }
    
    func updateRateText(rate: String) {
        rateLabel.text = rate
    }
    
    func throwAlert(message: String) {
        presentAlert(message: message)
    }
}