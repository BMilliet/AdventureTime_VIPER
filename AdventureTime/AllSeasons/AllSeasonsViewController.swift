import UIKit

class AllSeasonsViewController: UIViewController {

  @IBOutlet weak var logoutButton: UIButton!
  @IBOutlet weak var tableView: UITableView!

  var seasonsList: AllSeasons

  init(seasonsList: AllSeasons){
    self.seasonsList = seasonsList
    super.init(nibName: NibManager.allSeasons.viewSelected(), bundle:nil)
  }

  required init?(coder aDecoder: NSCoder) {fatalError()}

  override func viewDidLoad() {
    super.viewDidLoad()
    registerCell()
    setUpView()
  }

  private func setUpView() {
    tableView.delegate = self
    tableView.dataSource = self
    logoutButton.layer.cornerRadius = 15
  }

  private func registerCell() {
    let cell = UINib(nibName: SeasonViewCell.identifier, bundle: nil)
    tableView.register(cell, forCellReuseIdentifier: SeasonViewCell.identifier)
  }
}

extension AllSeasonsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return seasonsList.total()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SeasonViewCell.identifier, for: indexPath) as! SeasonViewCell

    let season = seasonsList.seasons[indexPath.row]
    cell.populate(with: season)

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return SeasonViewCell.cellHeight
  }
}
