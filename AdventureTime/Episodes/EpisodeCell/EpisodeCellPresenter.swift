import UIKit

class EpisodeCellPresenter {

  var delegate: EpisodeViewCellDelegate?
  let defaults = Defaults()
  var seasonNumber: Int?

  func switchStatus(_ id: Int) {
    if User.shared.allReadyWatchedEpisode(id: id, season: seasonNumber!) {
      delegate?.watchedStatus()
    } else {
      delegate?.notWatchedStatus()
    }
  }

  func tapOnWatched(with id: Int?) {
    if let currentId = id {
      User.shared.watchedEpisode(id: currentId, season: seasonNumber!)
      defaults.saveEpisodes()
      switchStatus(currentId)
    }
  }

  func getPosterImage(for image: CustomUIImage, with episode: Episode, at uiImage: UIImageView) {
    if hasPoster(for: episode) {
      image.loadAsync(with: episode.still_path!,
                      imagePlace: uiImage,
                      placeHolder: #imageLiteral(resourceName: "placeholder-img"))
    } else {
      uiImage.image = #imageLiteral(resourceName: "placeholder-img")
    }
  }

  private func hasPoster(for episode: Episode) -> Bool {
    return episode.still_path != nil
  }
}
