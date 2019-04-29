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

//  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    let movieId = movieList?.items[indexPath.row].id
//    let url = UrlManager().movieDetails(id: movieId!, userKey: dao.userKey)
//    API.makeRequest(url: url!, onSuccess: setMovie)
//  }
}
