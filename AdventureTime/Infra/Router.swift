import UIKit

class Router: Assembler {

  let navigation: UINavigationController?

  init(navigation: UINavigationController?) {
    self.navigation = navigation
  }

  func goToAllSeasonsView(with list: AllSeasons) {
    let allSeasons = resolve(list)
    navigation?.pushViewController(allSeasons, animated: true)
  }

  func goToAllEpisodesView(with list: AllEpisodes, season: Int) {
    let allEpisodes = resolve(list, season)
    navigation?.pushViewController(allEpisodes, animated: true)
  }
}
