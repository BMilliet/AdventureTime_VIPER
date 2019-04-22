import UIKit

protocol LoginViewControllerDelegate {
  func stopSpinnerAnimation()
  func startSpinnerAnimation()
  func showErrorMessage()
}
