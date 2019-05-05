import UIKit

class AllSeasonsViewController: UIViewController {

  @IBOutlet weak var logoutButton: UIButton!
  @IBOutlet weak var collectionView: UICollectionView!

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
    collectionView.delegate = self
    collectionView.dataSource = self
    logoutButton.layer.cornerRadius = 15
  }

  private func registerCell() {
    let cell = UINib(nibName: SeasonViewCell.identifier, bundle: nil)
    collectionView.register(cell, forCellWithReuseIdentifier: SeasonViewCell.identifier)
  }
}

extension AllSeasonsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return seasonsList.total()
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonViewCell.identifier, for: indexPath) as! SeasonViewCell

    let season = seasonsList.seasons[indexPath.row]

    cell.populate(with: season)
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: SeasonViewCell.currentWidth, height: SeasonViewCell.currentHeight)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let season = seasonsList.seasons[indexPath.row].season_number

    let url = UrlManager.season(number: season, userKey: User.shared.userKey!)


    API().makeRequest(url: url!, objectType: AllEpisodes.self) { (result: API.RequestResult) in
      switch result {
      case .success(let object):
        print(object)
      case .failure(let error):
        print(error)
      }
    }
  }
}
