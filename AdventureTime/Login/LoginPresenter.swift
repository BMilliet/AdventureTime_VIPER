import Foundation
import UIKit

class LoginPresenter {

  let delegate: LoginViewControllerDelegate
  let validation = "validateKeyRegex".localized()

  init(delegate: LoginViewControllerDelegate) {
    self.delegate = delegate
  }

  func buttonPushed(with fieldValue: String) {
    delegate.startSpinnerAnimation()
    if fieldValue.matchPattern(validation) {
      makeRequestWith(key: fieldValue)
      return
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
    delegate.goToAllSeasonsView(list)
  }

  private func onFailRequest(with error: Error) {
    delegate.showErrorMessage()
    delegate.stopSpinnerAnimation()
    delegate.cleanField()
    print("Unexpected resquest status code: \(error))")
  }

  private func onFieldError() {
    delegate.showErrorMessage()
    delegate.stopSpinnerAnimation()
    delegate.cleanField()
    //viewController.loginButton.isEnabled = false
  }
}
