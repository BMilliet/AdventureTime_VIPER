import Foundation

struct UrlManager {

  static private let APIBaseUrl = "https://api.themoviedb.org/3"
  static private let listOption = "/tv/15260"
  static private let movieDetailOption = "/movie/"
  static private let seasonPrefix = "/season/"
  static private let keyPrefix = "?api_key="
  static private let lenguage = "&language=en-US"

  static func completeInfo(userKey: String) -> URL? {
    let path = buildPath([APIBaseUrl,listOption,keyPrefix,userKey,lenguage])
    let url = URL(string: path)
    return url
  }

  static func season(number: Int, userKey: String) -> URL? {
    let stringURL = buildPath([APIBaseUrl,seasonPrefix,String(number),keyPrefix,userKey,lenguage])
    let url = URL(string: stringURL)
    return url
  }

  static private func buildPath(_ array: [String]) -> String {
    return array.joined()
  }
}
