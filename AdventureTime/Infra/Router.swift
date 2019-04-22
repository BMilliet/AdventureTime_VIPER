import UIKit

class Router {

  let navigation: UINavigationController?

  init(navigation: UINavigationController?) {
    self.navigation = navigation
  }

  func goToAllSeasonsView(with list: AllSeasons) {
    let allSeasons = AllSeasonsViewController(seasonsList: list)
    navigation?.pushViewController(allSeasons, animated: true)
  }
}
