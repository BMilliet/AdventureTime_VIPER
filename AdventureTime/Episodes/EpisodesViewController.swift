import UIKit

class EpisodesViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!

  var episodesList: AllEpisodes

  init(episodesList: AllEpisodes){
    self.episodesList = episodesList
    super.init(nibName: NibManager.seasonEpisodes.viewSelected(), bundle:nil)
  }

  required init?(coder aDecoder: NSCoder) {fatalError()}

  override func viewDidLoad() {
    super.viewDidLoad()
    registerCell()
  }

  private func registerCell() {
    let cell = UINib(nibName: EpisodeViewCell.identifier, bundle: nil)
    tableView.register(cell, forCellReuseIdentifier: EpisodeViewCell.identifier)
  }
}

extension EpisodesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return episodesList.total()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeViewCell.identifier, for: indexPath) as! EpisodeViewCell

    let episode = episodesList.episodes[indexPath.row]

    cell.populate(with: episode)
    return cell
  }
}
