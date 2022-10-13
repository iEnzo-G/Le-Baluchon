import UIKit

// Custom Field forbid user to do some interactions on the text field to prevent some errors.
final class CustomUITextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector((UIResponderStandardEditActions.select(_:))) {
            return false
        }
        if action == #selector(UIResponderStandardEditActions.selectAll(_:)) {
            return false
        }
        if action == #selector(UIResponderStandardEditActions.cut(_:)) {
            return false
        }
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return false
        }
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        if action == #selector(UIResponderStandardEditActions.delete(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
