protocol Assembler {
  func resolve(_ allSeasons: AllSeasons) -> AllSeasonsViewController
}

extension Assembler {
  func resolve(_ allSeasons: AllSeasons) -> AllSeasonsViewController {
    let presenter = AllSeasonsPresenter()
    return AllSeasonsViewController(seasonsList: allSeasons, presenter: presenter)
  }

  func resolve(_ allEpisodes: AllEpisodes) -> EpisodesViewController {
    return EpisodesViewController(episodesList: allEpisodes)
  }
}
