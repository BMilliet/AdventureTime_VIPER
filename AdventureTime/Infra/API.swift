import Foundation

class API {

  enum RequestError: Error {
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
  }

  enum RequestResult<T> {
    case success(T)
    case failure(RequestError)
  }

  private let session = URLSession.shared

  func makeRequest<T: Decodable>(url: URL, objectType: T.Type, completion: @escaping (RequestResult<T>) -> Void) {
    session.dataTask(with: url, completionHandler: { data, response, error in
      if let httpResponse = response as? HTTPURLResponse {
        let statusCode = httpResponse.statusCode
        if statusCode != 200 {
          completion(RequestResult.failure(RequestError.invalidStatusCode(statusCode)))
          return
        }
      }
      do {
        let decodedObject = try JSONDecoder().decode(objectType.self, from: data!)
        completion(RequestResult.success(decodedObject))
      } catch let error {
        completion(RequestResult.failure(RequestError.jsonParsingError(error as! DecodingError)))
      }
    }).resume()
  }
}
