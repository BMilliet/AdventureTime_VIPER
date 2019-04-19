import Foundation

struct UrlManager {

  private let APIBaseUrl = "https://api.themoviedb.org/3"
  private let listOption = "/tv/15260"
  private let movieDetailOption = "/movie/"
  private let seasonPrefix = "/season/"
  private let keyPrefix = "?api_key="
  private let lenguage = "&language=en-US"

  func completeInfo(userKey: String) -> URL? {
    let path = buildPath([APIBaseUrl,listOption,keyPrefix,userKey,lenguage])
    let url = URL(string: path)
    return url
  }

  func tryConnection(with key: String) -> URL? {
    let path = buildPath([APIBaseUrl,listOption,keyPrefix,key,lenguage])
    let url = URL(string: path)
    return url
  }

  func season(number: Int, userKey: String) -> URL? {
    let stringURL = buildPath([APIBaseUrl,seasonPrefix,String(number),keyPrefix,userKey,lenguage])
    let url = URL(string: stringURL)
    return url
  }

  private func buildPath(_ array: [String]) -> String {
    return array.joined()
  }
}
