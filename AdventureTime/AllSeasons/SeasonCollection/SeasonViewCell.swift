import UIKit

class SeasonViewCell: UICollectionViewCell {

  @IBOutlet weak var seasonName: UILabel!
  @IBOutlet weak var seasonPoster: UIImageView!
  @IBOutlet weak var episodeCount: UILabel!
  @IBOutlet weak var airDate: UILabel!

  static let currentHeight = CGFloat(250)
  static let currentWidth = CGFloat(150)

  static var identifier: String {
    return String(describing: SeasonViewCell.self)
  }

  func populate(with season: Season) {
    getPoster(season.poster_path)
    seasonName.text = season.name
    airDate.text = season.air_date
    episodeCount.text = String(season.episode_count)
  }

  func getPoster(_ path: String) {
    let posterData = UrlManager.getPosterData(with: path)
    seasonPoster.image = UIImage(data: posterData)
  }

  override func prepareForReuse() {
    seasonPoster.image = nil
    airDate.text?.removeAll()
    seasonName.text?.removeAll()
    episodeCount.text?.removeAll()
  }
}
