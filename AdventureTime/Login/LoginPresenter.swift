import Foundation
import UIKit

class LoginPresenter {

  var viewController: LoginViewControllerDelegate?
  var allSeasons: AllSeasons?

  func buttonPushed(with key: String?) {
    viewController?.startSpinnerAnimation()
    if key == nil {
      viewController?.stopSpinnerAnimation()
      return
    }
    makeRequestWith(key: key!)
  }

  private func makeRequestWith(key: String) {
    let url = UrlManager.completeInfo(userKey: key)
    API.makeRequest(url: url!, objectType: AllSeasons.self) { (result: API.RequestResult) in
      switch result {
      case .success(let object):
        self.viewController?.stopSpinnerAnimation()
        self.allSeasons = object
      case .failure(let error):
        print("got unexpected statuscode: \(error)")
        self.viewController?.stopSpinnerAnimation()
      }
    }
  }
}
