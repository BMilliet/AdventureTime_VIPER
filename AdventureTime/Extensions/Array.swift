import Foundation

extension Array where Element: Equatable {
  mutating func delete(_ element: Element) {
    if let index = self.index(of: element) {
      self.remove(at: index)
    }
  }
}
