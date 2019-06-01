import UIKit

class EpisodeViewCell: UITableViewCell, EpisodeViewCellDelegate {

  @IBOutlet weak var episodeNumber: UILabel!
  @IBOutlet weak var episodeTitle: UILabel!
  @IBOutlet weak var episodeOverview: UITextView!
  @IBOutlet weak var episodeImage: UIImageView!
  @IBOutlet weak var watchIcon: UIView!

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
    watchIcon.backgroundColor = .blue
    watched = true
  }

  func notWatchedStatus() {
    watchIcon.backgroundColor = .green
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
    watchIcon.addGestureRecognizer(gesture)
  }

  private func getPosterImage(for episode: Episode) {
    customImage.loadAsync(with: episode.still_path,
                          imagePlace: episodeImage,
                          placeHolder: #imageLiteral(resourceName: "placeholder-img"))
  }

  private func setUpPresenter() {
    presenter.delegate = self
    presenter.seasonNumber = seasonNumber
  }

  @objc private func tapOnWatched() {
    presenter.tapOnWatched(with: episodeId)
  }
}
