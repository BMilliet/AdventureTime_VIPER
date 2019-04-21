import UIKit

protocol LoginViewControllerDelegate {
  func goToNextView(_ list: AllSeasons)
  func stopSpinnerAnimation()
  func startSpinnerAnimation()
}

class LoginViewController: UIViewController, LoginViewControllerDelegate {

  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var keyField: UITextField!
  @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
  @IBOutlet weak var loginButton: UIButton!

  private let presenter = LoginPresenter()

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewController = self
    setUpView()
  }

  @objc private func checkKeyField() {
    loginButton.isEnabled = keyField.isFieldEmpty()
  }

  @IBAction func loginButtonAction(_ sender: UIButton) {
    presenter.buttonPushed(with: keyField.text)
  }

  func goToNextView(_ list: AllSeasons) {
    Router(navigation: navigationController!).goToAllSeasonsView(with: list)
  }

  private func setUpView() {
    navigationController?.setNavigationBarHidden(true, animated: true)
    activitySpinner.isHidden = true
    loginButton.isEnabled = false
    loginButton.layer.cornerRadius = 25
    keyField.addTarget(self, action: #selector(checkKeyField), for: .editingChanged)
  }

  func startSpinnerAnimation() {
    activitySpinner.isHidden = false
    activitySpinner.startAnimating()
  }

  func stopSpinnerAnimation() {
    activitySpinner.isHidden = true
    activitySpinner.stopAnimating()
  }
}
