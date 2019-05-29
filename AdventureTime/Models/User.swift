class User {
  var userKey: String?
  var watchedEpisodes = [Int]()
  static let shared = User()

  func watchedEpisode(id: Int) {
    if checkEpisode(id: id) {
      watchedEpisodes.delete(id)
    } else {
      watchedEpisodes.append(id)
    }
  }

  private func checkEpisode(id: Int) -> Bool {
    return watchedEpisodes.contains(id)
  }
}
