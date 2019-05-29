import UIKit

class EpisodesViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var backButton: UIButton!

  var episodesList: AllEpisodes

  init(episodesList: AllEpisodes){
    self.episodesList = episodesList
    super.init(nibName: NibManager.seasonEpisodes.viewSelected(), bundle:nil)
  }

  required init?(coder aDecoder: NSCoder) {fatalError()}

  override func viewDidLoad() {
    super.viewDidLoad()
    registerCell()
    setUpView()
  }

  @IBAction func goBack(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }

  private func registerCell() {
    let cell = UINib(nibName: EpisodeViewCell.identifier, bundle: nil)
    tableView.register(cell, forCellReuseIdentifier: EpisodeViewCell.identifier)
  }

  private func setUpView() {
    tableView.delegate = self
    tableView.dataSource = self
    backButton.layer.cornerRadius = 15
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
    cell.enableIconAction()
    
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return EpisodeViewCell.currentHeight
  }
}
