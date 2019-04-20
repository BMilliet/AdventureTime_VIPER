import Foundation

class JsonObjectBuilder {

  static func decode<T: Decodable>(value: Any, result: T.Type) -> T {
    let data = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
    let object = try! JSONDecoder().decode(T.self, from: data)
    return object
  }
}
