protocol LoginViewControllerDelegate {
  func goToNextView(_ list: AllSeasons)
  func stopSpinnerAnimation()
  func startSpinnerAnimation()
  func showErrorMessage()
}
