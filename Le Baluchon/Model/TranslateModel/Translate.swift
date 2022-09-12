
import Foundation

struct TranslateResponse: Decodable {
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
    
    func getTranslate() {
        //apikey : f419ed1c-47cd-33ac-fd74-cbff06750a2f:fx
        let url = URL(string: "https://api-free.deepl.com/v2/translate?text=" + frenchText + "?source_lang=FR?target_lang=EN")!
        
        service.load(url: url) { [weak self] result in
            switch result {
            case let .success(data):
                print(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        
    }
}
