import UIKit

extension UITextField {
  func isFieldEmpty() -> Bool {
    if let field = self.text {
      return field.trim() != ""
    }
    return false
  }
}
