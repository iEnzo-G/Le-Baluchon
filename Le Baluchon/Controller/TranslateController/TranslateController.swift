
import UIKit

class TranslateController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var frenchTextView: UITextView!
    @IBOutlet var englishTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    
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
    }
    
    @IBAction func tappedTranslateButton(_ sender: UIButton) {
        translate.frenchText = frenchTextView.text!
        translate.getTranslate()
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

