import Foundation

struct UrlManager {

  static private let english = "en-US"
  static private let portuguese = "pt-BR"
  static private let keyPrefix = "api_key"
  static private let lenguage = "language"
  static private let listOption = "/tv/15260"
  static private let seasonPrefix = "/season/"
  static private let movieDetailOption = "/movie/"
  static private let APIBaseUrl = "https://api.themoviedb.org/3"
  static private let APIPosterUrl = "https://image.tmdb.org/t/p/w500"

  static func completeInfo(userKey: String) -> URL? {
    let base = URL(string: buildPath([APIBaseUrl,listOption]))
    return buildParams(base, userKey)
  }

  static func season(number: Int, userKey: String) -> URL? {
    let base = URL(string: buildPath([APIBaseUrl,listOption,seasonPrefix,String(number)]))
    return buildParams(base, userKey)
  }

  static func posterData(with path: String) -> Data {
    let path = buildPath([APIPosterUrl,path])
    let posterPath = URL(string: path)
    let data = try! Data(contentsOf: posterPath!)
    return data
  }

  static private func buildParams(_ base: URL?, _ userKey: String) -> URL? {
    let queryItens = [URLQueryItem(name: keyPrefix, value: userKey),
                      URLQueryItem(name: lenguage, value: "en-US")]

    return base?.appending(queryItens)
  }

  static private func buildPath(_ array: [String]) -> String {
    return array.joined()
  }
}
