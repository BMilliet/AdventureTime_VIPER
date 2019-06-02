import Foundation

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


class Defaults {

  private let defaults = UserDefaults.standard
  private let user = User.shared

  func saveUser() {
    saveUserKey()
    saveEpisodes()
  }

  func opennedApp() {
    if isUserLogged() {
      setUser()
    }
  }

  private func setUser() {
    user.userKey = getUserKey()
    user.watchedEpisodes = getSavedEpisodes()
  }

  private func isUserLogged() -> Bool {
    return defaults.bool(forKey: "logged")
  }

  private func saveUserKey() {
    defaults.set(user.userKey, forKey: "userKey")
  }

  private func setUserLoggedStatus() {
    defaults.set(true, forKey: "logged")
  }

  private func getUserKey() -> String {
    return defaults.string(forKey: "userKey") ?? ""
  }

  private func saveEpisodes() {
    defaults.set(user.watchedEpisodes, forKey: "episodes")
  }

  private func getSavedEpisodes() -> [[Int]] {
    return defaults.array(forKey: "episodes") as? [[Int]] ?? [[Int]]()
  }
}

