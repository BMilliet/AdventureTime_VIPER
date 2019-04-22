import Foundation
import UIKit

class LoginPresenter {

  let viewController: LoginViewController
  let delegate: LoginViewControllerDelegate
  let validation = "validateKeyRegex".localized()

  init(viewController: LoginViewController, delegate: LoginViewControllerDelegate) {
    self.viewController = viewController
    self.delegate = delegate
  }

  func buttonPushed() {
    delegate.startSpinnerAnimation()
    if let key = viewController.keyField.text {
      if key.matchPattern(validation) {
        makeRequestWith(key: key)
        return
      }
    }
    onFieldError()
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
    viewController.keyField.cleanField()
    print("Unexpected resquest status code: \(error))")
  }

  private func onFieldError() {
    delegate.showErrorMessage()
    delegate.stopSpinnerAnimation()
    viewController.keyField.cleanField()
    viewController.loginButton.isEnabled = false
  }

  private func goToAllSeasonsView(_ list: AllSeasons) {
    if let navigation = viewController.navigationController {
      Router(navigation: navigation).goToAllSeasonsView(with: list)
    }
  }
}
