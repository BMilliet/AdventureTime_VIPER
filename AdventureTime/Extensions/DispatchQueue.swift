import Foundation

extension DispatchQueue {
  static func executeFromMainThread(_ completion: @escaping () -> Void) {
    self.main.async {
      completion()
    }
  }
}
