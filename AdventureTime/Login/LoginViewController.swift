import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var keyField: UITextField!
  @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
  @IBOutlet weak var loginButton: UIButton!

  private let presenter = LoginPresenter()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUp()
  }

  @objc private func checkKeyField() {
    loginButton.isEnabled = keyField.isFieldEmpty()
  }

  @IBAction func loginButtonAction(_ sender: UIButton) {
    startSpinnerAnimation()
  }

  private func setUp() {
    navigationController?.setNavigationBarHidden(true, animated: true)
    activitySpinner.isHidden = true
    loginButton.isEnabled = false
    loginButton.layer.cornerRadius = 25
    keyField.addTarget(self, action: #selector(checkKeyField), for: .editingChanged)
  }

  private func startSpinnerAnimation() {
    activitySpinner.isHidden = false
    activitySpinner.startAnimating()
  }

  private func stopSpinner() {
    activitySpinner.isHidden = true
    activitySpinner.stopAnimating()
  }
}
