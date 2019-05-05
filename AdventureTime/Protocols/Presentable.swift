protocol Presentable {
  func makeRequestWith(_ number: Int)
  func onFailRequest(with error: Error)
  func onSuccessRequest(with object: Decodable)
}

extension Presentable {
  func makeRequestWith(_ number: Int = 0) {

  }
}
