import Foundation
import UIKit

class LoginPresenter: Presentable {

  let defaults = Defaults()
  let delegate: LoginViewControllerDelegate
  let validation = "validateKeyRegex".localized()

  init(delegate: LoginViewControllerDelegate) {
    self.delegate = delegate
    checkForLastSession()
  }

  func buttonPushed(with fieldValue: String) {
    delegate.startSpinnerAnimation()
    if fieldValue.matchPattern(validation) {
      User.shared.userKey = fieldValue
      makeRequestWith()
      return
    }
    onFieldError()
  }

  func makeRequest() {
    let key = User.shared.userKey!
    let url = UrlManager.completeInfo(userKey: key)
    API().makeRequest(url: url!, objectType: AllSeasons.self) { (result: API.RequestResult) in
      switch result {
      case .success(let object):
        DispatchQueue.executeFromMainThread {
          self.onSuccessRequest(with: object)
          self.setUserForFirstLoggin(with: key, object: object)
        }
      case .failure(let error):
        DispatchQueue.executeFromMainThread {
          self.onFailRequest(with: error)
        }
      }
    }
  }

  func onSuccessRequest(with object: Decodable) {
    if let list = object as? AllSeasons {
      delegate.stopSpinnerAnimation()
      delegate.goToAllSeasonsView(list)
    }
  }

  func onFailRequest(with error: Error) {
    delegate.showErrorMessage()
    delegate.stopSpinnerAnimation()
    delegate.cleanField()
    delegate.disableButton()
    print("Unexpected resquest status code: \(error))")
  }

  private func onFieldError() {
    delegate.showErrorMessage()
    delegate.stopSpinnerAnimation()
    delegate.cleanField()
    delegate.disableButton()
  }

  private func setUserForFirstLoggin(with key: String, object: AllSeasons) {
    if !defaults.isUserLogged() {
      defaults.initializeSession(with: key, seasonNumber: object.total())
    }
  }

  private func checkForLastSession() {
    if defaults.isUserLogged() {
      defaults.recoverSession()
      makeRequest()
    }
  }
}
