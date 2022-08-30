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
    
    weak var delegate: UpdateDelegate?
    var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        return formatter
    }()
    
    private var rate: String = "" {
        didSet {
            delegate?.updateRateText(rate: rate)
        }
    }
    private var eurAmountText: String = ""
    private var usdAmountText: String = "" {
            didSet {
                delegate?.updateUSDAmount(usd: usdAmountText)
            }
    }
    
    let service = ExchangeRateLoader()
    let url = URL(string: "https://api.apilayer.com/fixer/latest?symbols=USD&base=EUR&apikey=Vxvy8dMQlAuKjbvNvkInyxUM6zpzz9JG")!
    
    // MARK: - Functions
    
    func getExchangeRate() {
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
    
    private func getRates(response: FixerResponse){
        rate = "Rate: " + String(format:"%f", response.rates["USD"]!)
    }
    
    private func convertEURToUSD(response: FixerResponse) {
        guard let rate: Double = response.rates["USD"] else {
            delegate?.throwAlert(message: "Please enter an amount before convert")
            return
        }
        guard rate != 0 else {
            delegate?.throwAlert(message: "Please enter a correct amount before convert")
            return
        }
        
        let amountEUR = Double(eurAmountText) ?? 1.00
        usdAmountText = String(amountEUR * rate)
    }
    
    }

