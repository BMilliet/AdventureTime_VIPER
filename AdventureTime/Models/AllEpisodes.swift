struct AllEpisodes: Decodable {
  let episodes: [Episode]

  func total() -> Int {
    return episodes.count
  }
}
