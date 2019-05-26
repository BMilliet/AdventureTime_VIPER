import UIKit

class EpisodeViewCell: UITableViewCell {

  @IBOutlet weak var episodeNumber: UILabel!
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var episodeOverview: UITextView!
  @IBOutlet weak var episodeImage: UIImageView!

  static let currentHeight = CGFloat(160)
  let imageCache = NSCache<NSString, UIImage>()

  static var identifier: String {
    return String(describing: EpisodeViewCell.self)
  }

  func populate(with episode: Episode) {
    getPoster(episode.still_path)
    episodeTitle.text = episode.name
    episodeOverview.text = episode.overview
    episodeNumber.text = String(episode.episode_number)
  }

  override func prepareForReuse() {
    episodeImage.image = nil
    episodeTitle.text?.removeAll()
    episodeNumber.text?.removeAll()
    episodeOverview.text?.removeAll()
  }

  func getPoster(_ path: String) {
    if let imageFromCache = imageCache.object(forKey: path as NSString) {
      episodeImage.image = imageFromCache
      return
    }

    DispatchQueue.main.async {
      let posterData = UrlManager.getPosterData(with: path)
      let image = UIImage(data: posterData)
      self.imageCache.setObject(image!, forKey: path as NSString)
      self.episodeImage.image = image
    }
  }
}
