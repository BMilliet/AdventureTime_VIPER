import Foundation

class Defaults {

  private let defaults = UserDefaults.standard
  private let user = User.shared

  func initializeSession(with key: String, seasonNumber: Int) {
    user.userKey = key
    user.watchedEpisodes = [[Int]](repeating: [], count: seasonNumber)
    setUserLoggedStatus()
    saveUserKey()
  }

  func saveUser() {
    saveUserKey()
    saveEpisodes()
  }

  func saveEpisodes() {
    defaults.set(user.watchedEpisodes, forKey: "episodes")
  }

  func recoverSession() {
    user.userKey = getUserKey()
    user.watchedEpisodes = getSavedEpisodes()
  }

  func isUserLogged() -> Bool {
    return defaults.bool(forKey: "logged")
  }

  func userLoggedout() {
    setUserLoggedoutStatus()
    user.userKey = ""
    user.watchedEpisodes = [[Int]]()
    saveUser()
  }

  private func saveUserKey() {
    defaults.set(user.userKey, forKey: "userKey")
  }

  private func setUserLoggedStatus() {
    defaults.set(true, forKey: "logged")
  }

  private func setUserLoggedoutStatus() {
    defaults.set(false, forKey: "logged")
  }

  private func getUserKey() -> String {
    return defaults.string(forKey: "userKey") ?? ""
  }

  private func getSavedEpisodes() -> [[Int]] {
    return defaults.array(forKey: "episodes") as? [[Int]] ?? [[Int]]()
  }
}
