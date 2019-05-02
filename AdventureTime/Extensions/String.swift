import Foundation

extension String {
  func trim() -> String {
    return self.trimmingCharacters(in: CharacterSet.whitespaces)
  }

  func matchPattern(_ pattern: String) -> Bool {
    return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
  }

  func localized(withComment comment: String? = nil) -> String {
    return NSLocalizedString(self, comment: comment ?? "")
  }
}
