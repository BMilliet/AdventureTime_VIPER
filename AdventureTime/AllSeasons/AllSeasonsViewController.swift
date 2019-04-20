import UIKit

class AllSeasonsViewController: UIViewController {

  @IBOutlet weak var logoutButton: UIButton!
  @IBOutlet weak var tableView: UITableView!

  var seasonsList: AllSeasons? = nil

  init(seasonsList: AllSeasons){
    super.init(nibName: "AllSeasonsViewController", bundle:nil)
    self.seasonsList = seasonsList
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
  }

  private func setUpView() {
    logoutButton.layer.cornerRadius = 15
  }
}
