protocol Assembler {
  func resolve(_ allSeasons: AllSeasons) -> AllSeasonsViewController
}

extension Assembler {
  func resolve(_ allSeasons: AllSeasons) -> AllSeasonsViewController {
    return AllSeasonsViewController(seasonsList: allSeasons)
  }
}
