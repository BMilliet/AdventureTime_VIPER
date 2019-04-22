import Foundation
import UIKit

class LoginPresenter {

  var viewController: LoginViewController
  var delegate: LoginViewControllerDelegate

  init(viewController: LoginViewController, delegate: LoginViewControllerDelegate) {
    self.viewController = viewController
    self.delegate = delegate
  }

  func buttonPushed() {
    delegate.startSpinnerAnimation()
    if let key = viewController.keyField.text {
      if isValidFormat(key) {
        makeRequestWith(key: viewController.keyField.text!)
        return
      }
    }
    delegate.stopSpinnerAnimation()
    viewController.keyField.cleanField()
    viewController.loginButton.isEnabled = false
  }

  private func isValidFormat(_ string: String) -> Bool {
    let pattern = "^[a-zA-Z0-9]*$"
    return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: string)
  }

  private func makeRequestWith(key: String) {
    let url = UrlManager.completeInfo(userKey: key)
    API().makeRequest(url: url!, objectType: AllSeasons.self) { (result: API.RequestResult) in
      switch result {
      case .success(let object):
        DispatchQueue.executeFromMainThread {
          self.onSuccessRequest(with: object)
        }
      case .failure(let error):
        DispatchQueue.executeFromMainThread {
          self.onFailRequest(with: error)
        }
      }
    }
  }

  private func onSuccessRequest(with list: AllSeasons) {
    delegate.stopSpinnerAnimation()
    goToAllSeasonsView(list)
  }

  private func onFailRequest(with error: Error) {
    delegate.showErrorMessage()
    delegate.stopSpinnerAnimation()
    print("Unexpected resquest status code: \(error))")
  }

  private func goToAllSeasonsView(_ list: AllSeasons) {
    if let navigation = viewController.navigationController {
      Router(navigation: navigation).goToAllSeasonsView(with: list)
    }
  }
}
