import Foundation

class API {

  enum APPError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
  }

  enum Result<T> {
    case success(T)
    case failure(APPError)
  }

  static func makeRequest<T: Decodable>(url: URL, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
    let session = URLSession.shared
    let task = session.dataTask(with: url, completionHandler: { data, response, error in

      guard error == nil else {
        completion(Result.failure(APPError.networkError(error!)))
        return
      }

      guard let data = data else {
        completion(Result.failure(APPError.dataNotFound))
        return
      }

      do {

        let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
        completion(Result.success(decodedObject))
      } catch let error {
        completion(Result.failure(APPError.jsonParsingError(error as! DecodingError)))
      }
    })
    task.resume()
  }
}
