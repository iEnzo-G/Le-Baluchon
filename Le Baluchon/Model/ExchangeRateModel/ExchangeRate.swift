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
    
    let service = ExchangeRateLoader()
    let url = URL(string: "https://api.apilayer.com/fixer/latest?symbols=USD&base=EUR&apikey=Vxvy8dMQlAuKjbvNvkInyxUM6zpzz9JG")!
    
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
    var eurAmountText: String = ""
    private var usdAmountText: String = "" {
        didSet {
            delegate?.updateUSDAmount(usd: usdAmountText)
        }
    }
    
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
        rate = "Rate: " + formatter.string(for: response.rates["USD"])!
    }
    
    private func convertEURToUSD(response: FixerResponse) {
        guard eurAmountText != "0", eurAmountText != "" else {
            delegate?.throwAlert(message: "Please enter a correct amount to convert.")
            return
        }
        guard let amountEUR = Double(eurAmountText) else { return }
        guard let rate: Double = response.rates["USD"] else { return }
        guard let result = formatter.string(for: amountEUR * rate) else { return }
        usdAmountText = result
    }
    
}