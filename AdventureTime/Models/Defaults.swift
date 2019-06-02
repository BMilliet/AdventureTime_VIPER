import Foundation

class Defaults {

  private let defaults = UserDefaults.standard
  private let user = User.shared

  func userLoggedIn() {
    setUserLoggedStatus()
    saveUserKey()
  }

  func saveUser() {
    saveUserKey()
    saveEpisodes()
  }

  func recoverSession() {
    setUser()
  }

  func isUserLogged() -> Bool {
    return defaults.bool(forKey: "logged")
  }

  private func setUser() {
    user.userKey = getUserKey()
    user.watchedEpisodes = getSavedEpisodes()
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
