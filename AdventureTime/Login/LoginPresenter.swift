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
    }
  }

  func isDataAvailable() -> Bool {
    return allSeasons != nil
  }
}
