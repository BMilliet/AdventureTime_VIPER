import Foundation

class LoginPresenter {

  func makeRequestWith(key: String) {
    let url = UrlManager().completeInfo(userKey: key)

//    API.makeRequest(url: url!, objectType: AllSeasons.self, completion: { result in
//      print(result)
//    })

    API.makeRequest(url: url!, objectType: AllSeasons.self) { (result: API.Result) in
      switch result {
      case .success(let object):
        print(object)
      case .failure(let error):
        print(error)
      }
    }
  }

  func isKeyValid(_ code: Int) -> Bool {
    return code == 200
  }
}
