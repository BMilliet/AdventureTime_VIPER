import UIKit

class EpisodeViewCell: UITableViewCell {

  @IBOutlet weak var episodeNumber: UILabel!
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var episodeOverview: UITextView!
  @IBOutlet weak var episodeImage: UIImageView!

  static let currentHeight = CGFloat(160)

  static var identifier: String {
    return String(describing: EpisodeViewCell.self)
  }

  func populate(with episode: Episode) {
    getPoster(episode.still_path)
    episodeTitle.text = episode.name
    episodeOverview.text = episode.overview
    episodeNumber.text = String(episode.episode_number)
  }

  func getPoster(_ path: String) {
    let posterData = UrlManager.posterData(with: path)
    episodeImage.image = UIImage(data: posterData)
  }

  override func prepareForReuse() {
    episodeImage.image = nil
    episodeTitle.text?.removeAll()
    episodeNumber.text?.removeAll()
    episodeOverview.text?.removeAll()
  }
}
