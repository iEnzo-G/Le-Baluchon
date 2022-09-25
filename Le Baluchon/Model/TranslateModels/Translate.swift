
import Foundation

struct TranslateResponse: Decodable {
    let translations: [Translation]
}
struct Translation: Decodable {
    let text: String
}
