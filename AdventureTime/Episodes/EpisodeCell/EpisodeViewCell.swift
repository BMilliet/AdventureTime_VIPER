import UIKit

class EpisodeViewCell: UITableViewCell {

  @IBOutlet weak var episodeNumber: UILabel!
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var episodeOverview: UITextView!
  @IBOutlet weak var episodeImage: UIImageView!
  @IBOutlet weak var watchIcon: UIView!


  static let currentHeight = CGFloat(160)
  let customImage = CustomUIImage()

  static var identifier: String {
    return String(describing: EpisodeViewCell.self)
  }

  func populate(with episode: Episode) {
    episodeTitle.text = episode.name
    episodeOverview.text = episode.overview
    episodeNumber.text = String(episode.episode_number)
    getPosterImage(for: episode)
  }

  override func prepareForReuse() {
    episodeImage.image = nil
    episodeTitle.text?.removeAll()
    episodeNumber.text?.removeAll()
    episodeOverview.text?.removeAll()
  }

  private func getPosterImage(for episode: Episode) {
    customImage.loadAsync(with: episode.still_path,
                          imagePlace: episodeImage,
                          placeHolder: #imageLiteral(resourceName: "placeholder-img"))
  }
}
