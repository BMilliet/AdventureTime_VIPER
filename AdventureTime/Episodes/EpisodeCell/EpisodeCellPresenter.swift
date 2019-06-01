class EpisodeCellPresenter {

  var delegate: EpisodeViewCellDelegate?
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
      switchStatus(currentId)
    }
  }
}
