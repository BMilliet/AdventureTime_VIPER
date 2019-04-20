import Foundation
import UIKit

class LoginPresenter {

  var viewController: LoginViewController?
  var allSeasons: AllSeasons?

  func makeRequestWith(key: String) {
    let url = UrlManager.completeInfo(userKey: key)
    API.makeRequest(url: url!, objectType: AllSeasons.self) { (result: API.RequestResult) in
      switch result {
      case .success(let object):
        self.allSeasons = object
      case .failure(let error):
        print("got unexpected statuscode: \(error)")
      }
      self.showAllSeasons()
    }
  }

  func isDataAvailable() -> Bool {
    return allSeasons != nil
  }

  func showAllSeasons() {
    let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    if isDataAvailable() {
      Router(navigation: navigationController!).goToAllSeasonsView(with: allSeasons!)
    }
  }
}
