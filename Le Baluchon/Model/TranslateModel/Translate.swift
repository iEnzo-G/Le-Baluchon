
import Foundation

struct TranslateResponse: Decodable {
    let translations: [Translation]
}
struct Translation: Decodable {
    let text: String
}


final class Translate {
    
    // MARK: - Properties
    
    
    
    var frenchText: String = ""
    private var englishText: String = "" {
        didSet {
            delegate?.updateEnglishTextField(text: englishText)
        }
    }
    
    let service = TranslateLoader()
    weak var delegate:  TranslateDelegate?
    

    
  
    // MARK: - Functions
    
    
    
    func getEnglishTranslate(response: TranslateResponse) {
        englishText = response.translations[0].text
    }
    
    
    func getTranslate() {
        service.load(frenchText: frenchText) { [weak self] result in
            switch result {
            case let .success(data):
                self?.getEnglishTranslate(response: data)
                print(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        
    }
}
