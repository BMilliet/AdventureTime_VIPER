import UIKit

class EpisodeViewCell: UITableViewCell, EpisodeViewCellDelegate {

  @IBOutlet weak var episodeNumber: UILabel!
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var episodeOverview: UITextView!
  @IBOutlet weak var episodeImage: UIImageView!
  @IBOutlet weak var statusIcon: UIImageView!
  
  static let currentHeight = CGFloat(160)
  let presenter = EpisodeCellPresenter()
  let customImage = CustomUIImage()
  var seasonNumber: Int?
  var episodeId: Int?
  var watched = false

  
  static var identifier: String {
    return String(describing: EpisodeViewCell.self)
  }

  func initializeCell(with episode: Episode, season: Int) {
    selectionStyle = .none
    seasonNumber = season
    populate(with: episode)
    enableIconAction()
    setUpPresenter()
    presenter.switchStatus(episode.id)
  }

  override func prepareForReuse() {
    episodeImage.image = nil
    episodeTitle.text?.removeAll()
    episodeNumber.text?.removeAll()
    episodeOverview.text?.removeAll()
  }

  func watchedStatus() {
    statusIcon.image = #imageLiteral(resourceName: "check")
    watched = true
  }

  func notWatchedStatus() {
    statusIcon.image = #imageLiteral(resourceName: "play")
    watched = false
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
    statusIcon.isUserInteractionEnabled = true
    statusIcon.addGestureRecognizer(gesture)
  }

  private func getPosterImage(for episode: Episode) {
    presenter.getPosterImage(for: customImage, with: episode, at: episodeImage)
  }

  private func setUpPresenter() {
    presenter.delegate = self
    presenter.seasonNumber = seasonNumber
  }

  @objc private func tapOnWatched() {
    presenter.tapOnWatched(with: episodeId)
  }
}
