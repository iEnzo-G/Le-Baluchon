//
//  TranslateTest.swift
//  TranslateTest
//
//  Created by Enzo Gammino on 19/09/2022.
//

import XCTest
@testable import Le_Baluchon

class TranslateTest: XCTestCase {
    
    // MARK: - Tests
    
    func test_GivenFrenchText_WhenTappedTranslateButton_ThenTranslateToEnglishText() {
        let (sut, controller) = makeSUT()
        sut.frenchText = "Salut, j'aime le chocolat."
    }

    // MARK: - Helpers
    
    private func makeSUT() -> (model: Translate, controller: ControllerSpy) {
        let model = Translate()
        let controller = ControllerSpy()
        model.delegate = controller
        return (model, controller)
    }
    
    ///  A spy used to obtain information that the model returns to the controller.
    private class ControllerSpy: NSObject, TranslateDelegate {
        var expectedMessage: String = ""
        var expectedEnglishText: String = ""
        
        func throwAlert(message: String) {
            expectedMessage = message
        }
        
        func updateEnglishTextField(text: String) {
            expectedEnglishText = text
        }
    }
}
