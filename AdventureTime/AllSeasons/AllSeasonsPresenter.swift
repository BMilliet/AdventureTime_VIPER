import Foundation
import UIKit

class AllSeasonsPresenter: Presentable {

  var delegate: AllSeasonsViewControllerDelegate?
  var seasonNumber: Int?

  func makeRequestWith(number: Int) {
    seasonNumber = number
    let key = User.shared.userKey!
    let url = UrlManager.season(number: number, userKey: key)
    API().makeRequest(url: url!, objectType: AllEpisodes.self) { (result: API.RequestResult) in
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

  func onFailRequest(with error: Error) {
    print(error)
  }

  func onSuccessRequest(with object: Decodable) {
    if let list = object as? AllEpisodes {
      delegate?.goToAllEpisodes(list)
    }
  }
}
