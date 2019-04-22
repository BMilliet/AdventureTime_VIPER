import UIKit

protocol LoginViewControllerDelegate {
  func stopSpinnerAnimation()
  func startSpinnerAnimation()
  func showErrorMessage()
  func cleanField()
  func goToAllSeasonsView(_ list: AllSeasons)
}
