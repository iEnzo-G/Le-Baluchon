//
//  LeBaluchonTest.swift
//  LeBaluchonTest
//
//  Created by Enzo Gammino on 19/09/2022.
//

import XCTest
@testable import Le_Baluchon

class ExchangeRateTest: XCTestCase {
    
    // MARK: - Tests
    
    func test_GivenEurAmount_WhenTapped_ThenUpdateUsdAmount() {
        let (sut, controller) = makeSUT()
        sut.eurAmountText = "5"
        sut.rate = 2.00
        sut.convertEURToUSD()
        XCTAssertEqual(controller.expectedUSD, "10")
    }
    
    func test_GivenUseApp_WhenUserIsOnExchangeRateView_ThenUpdateRate() {
        
    }
    
    func test_GivenZeroAmount_WhenUsertappedOverTwoZero_ThenThrowErrorMessage() {
        let (sut, controller) = makeSUT()
        sut.eurAmountText = "00"
        sut.convertEURToUSD()
        XCTAssertEqual(controller.expectedMessage, "Please enter a correct amount to convert.")
    }

    
    // MARK: - Helpers
    
    /// Class help for testing answer without using request
    class FakeResponseData {
        static let responseCorrect = HTTPURLResponse(url: URL(string: "https://www.api.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        static let responseError = HTTPURLResponse(url: URL(string: "https://www.api.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
        
        class ExchangeError {}
        static let error = ExchangeError()
        
        static var exchangeCorrectData: Data {
            let bundle = Bundle(for: ExchangeRateTest.self)
            let url = bundle.url(forResource: "ExchangeRate", withExtension: "json")
            let data = try! Data(contentsOf: url!)
            return data
        }
        
        static let exchangeIncorrectData = "erreur".data(using: .utf8)!
    }
    
    private func makeSUT() -> (model: ExchangeRate, controller: ControllerSpy) {
        let model = ExchangeRate()
        let controller = ControllerSpy()
        model.delegate = controller
        return (model, controller)
    }
    
    ///  A spy used to obtain information that the model returns to the controller.
    private class ControllerSpy: NSObject, UpdateCurrencyDelegate {
        var expectedMessage: String = ""
        var expectedUSD: String = ""
        var expectedRate: String = ""
        
        func throwAlert(message: String) {
            expectedMessage = message
        }
        
        func updateUSDAmount(usd: String) {
            expectedUSD = usd
        }
        
        func updateRateText(rate: String) {
            expectedRate = rate
        }
        
        
    }
}
