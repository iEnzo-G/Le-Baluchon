//
//  ExchangeRate.swift
//  Le Baluchon
//
//  Created by Enzo Gammino on 15/08/2022.
//

import Foundation

struct FixerResponse: Decodable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Double]
}

final class ExchangeRate {
    // MARK: - Properties
    
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        return formatter
    }()
    
    var rates: String = "0"
    
    // MARK: - Functions
    
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
        if EURAmountTextField.becomeFirstResponder() {
            EURAmountTextField.text = ""
        }
    }
}

