import UIKit

class SeasonViewCell: UITableViewCell {

  @IBOutlet weak var seasonPoster: UIImageView!
  @IBOutlet weak var seasonName: UILabel!
  @IBOutlet weak var seasonOverview: UITextView!
  @IBOutlet weak var episodeCount: UILabel!
  @IBOutlet weak var airDate: UILabel!

  static let cellHeight: CGFloat = 194

  static var identifier: String {
    return String(describing: SeasonViewCell.self)
  }

  func populate(with season: Season) {
    getPoster(season.poster_path)
    seasonName.text = season.name
    airDate.text = season.air_date
    seasonOverview.text = season.overview
    seasonOverview.text = season.overview
    episodeCount.text = String(season.episode_count)
  }

  func getPoster(_ path: String) {
    let posterData = UrlManager.posterData(with: path)
    seasonPoster.image = UIImage(data: posterData)
  }

  override func prepareForReuse() {
    seasonPoster.image = nil
    airDate.text?.removeAll()
    seasonName.text?.removeAll()
    episodeCount.text?.removeAll()
    seasonOverview.text?.removeAll()
  }
}
