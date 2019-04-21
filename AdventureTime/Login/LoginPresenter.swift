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
    //makeRequestWith(key: key!)
    makeAnotherRequest(key: key!)
//    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
//      self.performAction()
//    })
    onFailRequest()
  }

  private func makeRequestWith(key: String) {
    let url = UrlManager.completeInfo(userKey: key)
    API().makeRequest(url: url!, objectType: AllSeasons.self) { (result: API.RequestResult) in
      switch result {
      case .success(let object):
        self.allSeasons = object
      case .failure(let error):
        self.apiError = error
      }
    }
  }

  private func makeAnotherRequest(key: String) {
    let url = UrlManager.completeInfo(userKey: key)
    API().execute(url: url!, objectType: AllSeasons.self, onSuccess: {statusCode, response in
      print("------------")
      print(statusCode)
      print(response)
      self.onFailRequest()
    }, onError: {statusCode, error in
      print("------------")
      print(statusCode)
      print(error as Any)
      //self.onFailRequest()
    })
  }

  func performAction() {
    apiError == nil ? onSuccessRequest(): onFailRequest()
  }


  func onSuccessRequest() {
    viewController?.stopSpinnerAnimation()
    viewController?.goToNextView(allSeasons!)
  }

  func onFailRequest() {
    viewController?.showErrorMessage()
    viewController?.stopSpinnerAnimation()
    print("Unexpected resquest status code: \(String(describing: apiError))")
  }
}
