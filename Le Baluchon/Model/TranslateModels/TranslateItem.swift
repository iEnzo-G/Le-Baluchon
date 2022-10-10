
import Foundation

struct TranslateItem: Decodable {
    let translations: [Translation]
}
struct Translation: Decodable {
    let text: String
}
