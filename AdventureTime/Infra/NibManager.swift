import UIKit

enum NibManager {
  case login
  case allSeasons
  case seasonEpisodes

  func viewSelected() -> String {
    switch self {
    case .login: return "LoginViewController"
    case .allSeasons: return "AllSeasonsViewController"
    case .seasonEpisodes: return "EpisodesViewController"
    }
  }
}
