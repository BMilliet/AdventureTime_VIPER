class User {
  var userKey: String?
  var watchedEpisodes = [Int]()
  static let shared = User()

  func watchedEpisode(id: Int) {
    if allReadyWatchedEpisode(id: id) {
      watchedEpisodes.delete(id)
    } else {
      watchedEpisodes.append(id)
    }
  }

  func allReadyWatchedEpisode(id: Int) -> Bool {
    return watchedEpisodes.contains(id)
  }
}
