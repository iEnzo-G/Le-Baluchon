
import UIKit

final class TranslateController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var frenchTextView: UITextView!
    @IBOutlet weak var englishTextView: UITextView!
    
    // MARK: - Properties
    
    private let translate = Translate()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translate.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAndTranslate)))
    }
    
    // MARK: - Actions
    
    @objc private func dismissKeyboardAndTranslate() {
        frenchTextView.resignFirstResponder()
        translate.frenchText = frenchTextView.text!
//        translate.getTranslate()
    }
    
    
}

// MARK: - Extension

extension TranslateController: TranslateDelegate {
    func updateEnglishTextField(text: String) {
        englishTextView.text = text
    }
    
    func throwAlert(message: String) {
        presentAlert(message: message)
    }
    
    
}

