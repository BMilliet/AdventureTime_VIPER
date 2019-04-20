import Foundation

class LoginPresenter {

  var viewController: LoginViewController?

  func makeRequestWith(key: String) {
    let url = UrlManager().completeInfo(userKey: key)

    API.makeRequest(url: url!, objectType: AllSeasons.self) { (result: API.RequestResult) in
      switch result {
      case .success(let object):
        print(object)
      case .failure(let error):
        print(error)
      }
    }
  }
}
