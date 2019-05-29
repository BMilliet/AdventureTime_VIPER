import UIKit

class EpisodeViewCell: UITableViewCell {

  @IBOutlet weak var episodeNumber: UILabel!
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var episodeOverview: UITextView!
  @IBOutlet weak var episodeImage: UIImageView!
  @IBOutlet weak var watchIcon: UIView!

  static let currentHeight = CGFloat(160)
  let customImage = CustomUIImage()
  var episodeId: Int?

  
  static var identifier: String {
    return String(describing: EpisodeViewCell.self)
  }

  func initializeCell(with episode: Episode) {
    populate(with: episode)
    enableIconAction()
    switchIcon(episode.id)
  }

  override func prepareForReuse() {
    episodeImage.image = nil
    episodeTitle.text?.removeAll()
    episodeNumber.text?.removeAll()
    episodeOverview.text?.removeAll()
  }

  private func populate(with episode: Episode) {
    episodeTitle.text = episode.name
    episodeOverview.text = episode.overview
    episodeNumber.text = String(episode.episode_number)
    getPosterImage(for: episode)
    episodeId = episode.id
  }

  private func enableIconAction() {
    let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnWatched))
    watchIcon.addGestureRecognizer(gesture)
  }

  private func getPosterImage(for episode: Episode) {
    customImage.loadAsync(with: episode.still_path,
                          imagePlace: episodeImage,
                          placeHolder: #imageLiteral(resourceName: "placeholder-img"))
  }

  private func switchIcon(_ id: Int) {
    if User.shared.allReadyWatchedEpisode(id: id) {
      watchIcon.backgroundColor = .blue
    } else {
      watchIcon.backgroundColor = .green
    }
  }

  @objc private func tapOnWatched() {
    if let id = episodeId {
      User.shared.watchedEpisode(id: id)
      switchIcon(id)
    }
  }
}
