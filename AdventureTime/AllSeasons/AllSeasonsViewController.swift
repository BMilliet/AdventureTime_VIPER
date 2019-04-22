import UIKit

class AllSeasonsViewController: UIViewController {

  @IBOutlet weak var logoutButton: UIButton!
  @IBOutlet weak var tableView: UITableView!

  var seasonsList: AllSeasons

  init(seasonsList: AllSeasons){
    self.seasonsList = seasonsList
    super.init(nibName: "AllSeasonsViewController", bundle:nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
  }

  private func setUpView() {
    logoutButton.layer.cornerRadius = 15
  }
}
