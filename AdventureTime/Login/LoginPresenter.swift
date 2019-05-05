import Foundation
import UIKit

class LoginPresenter: Presentable {

  let delegate: LoginViewControllerDelegate
  let validation = "validateKeyRegex".localized()

  init(delegate: LoginViewControllerDelegate) {
    self.delegate = delegate
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

  func makeRequestWith() {
    let key = User.shared.userKey!
    let url = UrlManager.completeInfo(userKey: key)
    API().makeRequest(url: url!, objectType: AllSeasons.self) { (result: API.RequestResult) in
      switch result {
      case .success(let object):
        DispatchQueue.executeFromMainThread {
          self.onSuccessRequest(with: object)
          User.shared.userKey = key
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
}
