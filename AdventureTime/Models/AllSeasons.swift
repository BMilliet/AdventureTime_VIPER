struct AllSeasons: Decodable {
  let seasons: [Season]

  func total() -> Int {
    return seasons.count
  }
}
