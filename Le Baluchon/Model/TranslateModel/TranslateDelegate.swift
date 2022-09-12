import Foundation

// Communicate between Model and Controller
protocol TranslateDelegate: NSObject {
    func throwAlert(message: String)
    func updateEnglishTextField(text: String)
}
