import UIKit

class EpisodeViewCell: UITableViewCell {

  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var episodeOverview: UITextView!
  @IBOutlet weak var episodeImage: UIImageView!

  static let currentHeight = CGFloat(160)

  static var identifier: String {
    return String(describing: SeasonViewCell.self)
  }

  func populate(with episode: Episode) {
    getPoster(episode.still_path)
    episodeTitle.text = episode.name
    episodeOverview.text = episode.overview
  }

  func getPoster(_ path: String) {
    let posterData = UrlManager.posterData(with: path)
    episodeImage.image = UIImage(data: posterData)
  }

  override func prepareForReuse() {
    episodeImage.image = nil
    episodeTitle.text?.removeAll()
    episodeOverview.text?.removeAll()
  }
}
