protocol LoginViewControllerDelegate {
  func cleanField()
  func disableButton()
  func showErrorMessage()
  func stopSpinnerAnimation()
  func startSpinnerAnimation()
  func goToAllSeasonsView(_ list: AllSeasons)
}
