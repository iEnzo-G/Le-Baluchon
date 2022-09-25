
import UIKit

class TranslateController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var frenchTextView: UITextView!
    @IBOutlet var englishTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    
    // MARK: - Properties
    
    private let loader = TranslateLoader()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAndTranslate)))
    }
    
    // MARK: - Actions
    
    @objc private func dismissKeyboardAndTranslate() {
        frenchTextView.resignFirstResponder()
    }
    
    @IBAction func tappedTranslateButton(_ sender: UIButton) {
        guard frenchTextView.text != "" else {
            presentAlert(message: "Please write something before translate")
            return
        }
        loader.load(text: frenchTextView.text!) { [weak self] result in
            switch result {
            case let .success(text):
                self?.englishTextView.text = text.translations[0].text
            case let .failure(error):
                print(error.localizedDescription)
                self?.presentAlert(message: "Something happened wrong from the API. Please try later.")
            }
        }
    }
    
}
