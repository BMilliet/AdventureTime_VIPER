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
    //seasonPoster.image = UIImage(data: logo)
    seasonName.text = season.name
    seasonOverview.text = season.overview
    episodeCount.text = String(season.episode_count)
    airDate.text = season.air_date
  }
}
