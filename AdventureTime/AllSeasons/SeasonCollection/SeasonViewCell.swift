import UIKit

class SeasonViewCell: UICollectionViewCell {

  @IBOutlet weak var seasonName: UILabel!
  @IBOutlet weak var seasonPoster: UIImageView!
  @IBOutlet weak var episodeCount: UILabel!
  @IBOutlet weak var airDate: UILabel!

  static let currentHeight = CGFloat(300)
  static let currentWidth = CGFloat(150)
  let customImage = CustomUIImage()

  
  static var identifier: String {
    return String(describing: SeasonViewCell.self)
  }

  func populate(with season: Season) {
    seasonName.text = season.name
    airDate.text = season.air_date
    episodeCount.text = setEpisodeCount(season)
    getPosterImage(for: season)
  }

  override func prepareForReuse() {
    seasonPoster.image = nil
    airDate.text?.removeAll()
    seasonName.text?.removeAll()
    episodeCount.text?.removeAll()
  }

  private func setEpisodeCount(_ season: Season) -> String {
    let total = String(season.episode_count)
    let current = String(User.shared.watchedEpisodesFor(season: season.season_number))
    return current + "/" + total
  }

  private func getPosterImage(for season: Season) {
    customImage.loadAsync(with: season.poster_path,
                          imagePlace: seasonPoster,
                          placeHolder: #imageLiteral(resourceName: "placeholder-img"))
  }
}
