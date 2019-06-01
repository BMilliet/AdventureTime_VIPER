import Foundation

extension URL {
  func appending(_ queryItems: [URLQueryItem]) -> URL? {
    guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
      return nil
    }
    urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
    return urlComponents.url
  }
}
