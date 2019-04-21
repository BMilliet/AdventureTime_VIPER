import Foundation
import UIKit

class LoginPresenter {

  var viewController: LoginViewControllerDelegate?
  var allSeasons: AllSeasons?
  var apiError: API.RequestError?

  func buttonPushed(with key: String?) {
    viewController?.startSpinnerAnimation()
    if key == nil {
      viewController?.stopSpinnerAnimation()
      return
    }
    makeRequestWith(key: key!)
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
      self.performAction()
    })
  }

  private func makeRequestWith(key: String) {
    let url = UrlManager.completeInfo(userKey: key)
    API.makeRequest(url: url!, objectType: AllSeasons.self) { (result: API.RequestResult) in
      switch result {
      case .success(let object):
        self.allSeasons = object
      case .failure(let error):
        self.apiError = error
      }
    }
  }

  func performAction() {
    apiError == nil ? onSuccessRequest(): onFailRequest()
  }


  func onSuccessRequest() {
    viewController?.stopSpinnerAnimation()
    viewController?.goToNextView(allSeasons!)
  }

  func onFailRequest() {
    viewController?.stopSpinnerAnimation()
    print("Unexpected resquest status code: \(String(describing: apiError))")
  }
}
