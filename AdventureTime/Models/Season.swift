struct Season: Decodable {
  let id: Int
  let name: String
  let air_date: String
  let overview: String?
  let episode_count: Int
  let season_number: Int
  let poster_path: String
  var watchedEpisodeCount = 0
}
