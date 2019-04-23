import UIKit

enum NibManager {
  case login
  case allSeasons

  func viewSelected() -> String {
    switch self {
    case .login: return "LoginViewController"
    case .allSeasons: return "AllSeasonsViewController"
    }
  }
}
