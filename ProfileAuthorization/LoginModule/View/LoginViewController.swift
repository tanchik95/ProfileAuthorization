import UIKit
class LoginViewController: UIViewController {
	
	let networkManager = LoginController()
	let profileView = MainProfileViewController()



	private let loginLabel: UILabel = {
		let label = UILabel()
		label.text = "Вход в аккаунт"
		label.font = UIFont.boldSystemFont(ofSize: 22)
		label.tintColor = .black
		label.numberOfLines = 1
		label.textAlignment = .left
		label.layer.cornerRadius = 5
		return label
	}()
	
	private let forgotPasswordLabel: UIButton = {
		let button = UIButton()
		button.setTitle("Забыли пароль?", for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		button.setTitleColor(.gray, for: .normal)
		return button
	}()
	

	private let userNametextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
		textField.placeholder = "Email"
		textField.leftView = UIImageView(image: UIImage(systemName: "at"))
		textField.leftView?.tintColor = .gray
		textField.leftViewMode = .always
		return textField
	}()
	
	private let passwordTextField: UITextField = {
		let textField = UITextField()
		textField.borderStyle = .roundedRect
		textField.placeholder = "Пароль"
		textField.isSecureTextEntry = true
		textField.leftView = UIImageView(image: UIImage(systemName: "lock"))
		textField.leftView?.tintColor = .gray
		textField.leftViewMode = .always
		textField.rightView = UIImageView(image: UIImage(systemName: "eye.slash.fill"))
		textField.rightView?.tintColor = .gray
		textField.rightViewMode = .always
		return textField
	}()
	
	private let loginButton: UIButton = {
		let button = UIButton()
		button.setTitle("Войти", for: .normal)
		button.backgroundColor = UIColor(red: 255/255.0, green: 191/255.0, blue: 96/255.0, alpha: 1)
		button.layer.cornerRadius = 5
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()

		loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
	}


	private func setupView() {
		view.backgroundColor = .white

		let textFieldStackView = UIStackView(arrangedSubviews: [userNametextField, passwordTextField])
		textFieldStackView.axis = .vertical
		textFieldStackView.spacing = 20


		view.addSubview(loginLabel)
		view.addSubview(textFieldStackView)
		view.addSubview(loginButton)

		let barButtonItem = UIBarButtonItem(customView: forgotPasswordLabel)

		navigationItem.rightBarButtonItem = barButtonItem

		loginLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(30) // Используйте safeAreaLayoutGuide для правильного расположения
			make.left.equalTo(view).offset(8)
			make.right.equalTo(view).offset(-8)
			make.height.equalTo(Sizes.L.height)
		}

		textFieldStackView.snp.makeConstraints { make in
			make.top.equalTo(loginLabel.snp.bottom).offset(30)
			make.left.equalTo(view).offset(8)
			make.right.equalTo(view).offset(-8)
		}

		userNametextField.snp.makeConstraints { make in
			make.height.equalTo(Sizes.L.height)
		}

		passwordTextField.snp.makeConstraints { make in
			make.height.equalTo(Sizes.L.height)
		}

		loginButton.snp.makeConstraints { make in
			make.top.equalTo(textFieldStackView.snp.bottom).offset(30)
			make.left.equalTo(view).offset(8)
			make.right.equalTo(view).offset(-8)
			make.height.equalTo(Sizes.L.height)
		}
	}

	@objc private func handleLogin() {

		guard let username = userNametextField.text, !username.isEmpty,
			  let password = passwordTextField.text, !password.isEmpty else {
			print("Имя пользователя или пароль не должны быть пустыми.")
			return
		}


		networkManager.authorize(username: username, password: password) { [weak self] authorizationResponse in
			guard let self = self else { return }

			// Проверяем, успешна ли авторизация
			if let authorizationResponse = authorizationResponse, authorizationResponse.code == 200 {
				print("Авторизация успешна: \(authorizationResponse)")

				// Вызываем функцию из MainProfileViewController
				profileView.fetchDashboardRequest()

			} else {
				print("Авторизация не удалась или код ответа не 200.")
			}
		}

		let mainProfile = ProfileViewController()
		mainProfile.modalPresentationStyle = .fullScreen
		self.present(mainProfile, animated: true, completion: nil)
	}
}


