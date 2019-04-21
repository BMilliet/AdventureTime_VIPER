import Foundation

class API {

  typealias onSuccess = (_ statusCode: Int, _ response: Decodable) -> Void
  typealias onError = (_ statusCode: Int, _ error: Error?) -> Void

  private let session = URLSession.shared

  func makeRequest<T: Decodable>(url: URL, objectType: T.Type, completion: @escaping (RequestResult<T>) -> Void) {
    let session = URLSession.shared
    let task = session.dataTask(with: url, completionHandler: { data, response, error in
      
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
    })
    task.resume()
  }

  func execute<T: Decodable>(url: URL, objectType: T.Type, onSuccess: @escaping onSuccess, onError: @escaping onError) {
    session.dataTask(with: url, completionHandler: { (data, response, error) in
      let apiResponse = ApiResponse(data: data, response: response, error: error)
      if apiResponse.isSuccess() {
        onSuccess(apiResponse.statusCode(), apiResponse.jsonResponse(objectType))
      } else {
        onError(apiResponse.statusCode(), apiResponse.error)
      }
    }).resume()
  }

//-----------------------------
  enum RequestError: Error {
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
  }

  enum RequestResult<T> {
    case success(T)
    case failure(RequestError)
  }
}

struct ApiResponse {
  var data: Data?
  var response: URLResponse?
  var error: Error?

  func jsonResponse<T: Decodable>(_ objectType: T.Type) -> T? {
    let decodedObject = try! JSONDecoder().decode(objectType.self, from: data!)
    return decodedObject
  }

  func statusCode() -> Int {
    let httpResponse = response as? HTTPURLResponse
    return httpResponse?.statusCode ?? 0
  }

  func isSuccess() -> Bool {
    return statusCode() == 200
  }
}

