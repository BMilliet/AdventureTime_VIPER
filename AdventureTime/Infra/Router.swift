import UIKit

class Router: Assembler{

  let navigation: UINavigationController?

  init(navigation: UINavigationController?) {
    self.navigation = navigation
  }

  func goToAllSeasonsView(with list: AllSeasons) {
    let allSeasons = resolve(list)
    navigation?.pushViewController(allSeasons, animated: true)
  }
}
