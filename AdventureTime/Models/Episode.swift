struct Episode: Decodable {
  let air_date: String
  let episode_number: Int
  let id: Int
  let name: String
  let overview: String
  let still_path: String?
  let vote_average: Double
}
