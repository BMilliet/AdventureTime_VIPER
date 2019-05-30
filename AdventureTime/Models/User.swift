class User {
  
  var userKey: String?
  var watchedEpisodes = [[Int]]()
  static let shared = User()

  func watchedEpisode(id: Int, season: Int) {
    if allReadyWatchedEpisode(id: id, season: season) {
      watchedEpisodes[season].delete(id)
    } else {
      watchedEpisodes[season].append(id)
    }
  }

  func allReadyWatchedEpisode(id: Int, season: Int) -> Bool {
    return watchedEpisodes[season].contains(id)
  }

  func watchedEpisodesFor(season: Int) -> Int {
    return watchedEpisodes[season].count
  }
}


