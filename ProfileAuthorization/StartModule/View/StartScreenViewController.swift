//
//  StartScreenViewController.swift
//  ProfileAuthorization
//
//  Created by Татьяна Исаева on 29.08.2024.
//

import UIKit
import SnapKit

class StartScreenViewController: UIViewController {

	private let welcomeLabel: UILabel = {
		let label = UILabel()
		label.text = "Добро пожаловать!"
		label.font = UIFont.boldSystemFont(ofSize: 46)
		label.tintColor = .black
		label.numberOfLines = 2
		label.textAlignment = .left
		label.layer.cornerRadius = 5
		label.clipsToBounds = true
		return label
	}()

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Авторизируйтесь, чтобы продолжить работу"
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.textAlignment = .left
		label.textColor = .gray
		label.layer.cornerRadius = 5
		return label
	}()

	private let loginButton: UIButton = {
		let button = UIButton()
		button.setTitle("Вход", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
		button.backgroundColor = UIColor(red: 255/255.0, green: 191/255.0, blue: 96/255.0, alpha: 1)
		button.layer.cornerRadius = 5
		return button
	}()

	private let registrationButton: UIButton = {
		let button = UIButton()
		button.setTitle("Регистрация", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
		button.layer.borderColor = UIColor.systemGray.cgColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 5
		return button
	}()

	private let subtitleImage: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(systemName: "house")
		image.contentMode = .scaleAspectFit
		return image
	}()

	private let subtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Пригласить управлять своим домом"
		label.font = UIFont.systemFont(ofSize: 17)
		label.textColor = .systemBlue
		label.textAlignment = .left
		label.layer.cornerRadius = 5
		return label
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()

		loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
	}

	private func setupView() {
		view.backgroundColor = .white

		// Устанавливаем авторазметку
		let buttonsStackView = UIStackView(arrangedSubviews: [loginButton, registrationButton])
		buttonsStackView.axis = .vertical
		buttonsStackView.spacing = 20

		let subtitleStackView = UIStackView(arrangedSubviews: [subtitleImage, subtitleLabel])
		subtitleStackView.axis = .horizontal
		subtitleStackView.spacing = 20

		view.addSubview(welcomeLabel)
		view.addSubview(titleLabel)
		view.addSubview(buttonsStackView)
		view.addSubview(subtitleStackView)

		welcomeLabel.snp.makeConstraints { make in
			make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
			make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
			make.bottom.equalTo(titleLabel.snp.top).offset(-30)
		}

		titleLabel.snp.makeConstraints { make in
			make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
			make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
			make.bottom.equalTo(buttonsStackView.snp.top).offset(-30)
		}

		buttonsStackView.snp.makeConstraints { make in
			make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
			make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
			make.bottom.equalTo(subtitleStackView.snp.top).offset(-30)
		}

		loginButton.snp.makeConstraints { make in
			make.height.equalTo(50)
		}

		registrationButton.snp.makeConstraints { make in
			make.height.equalTo(50)
		}

		subtitleImage.snp.makeConstraints { make in
			make.width.height.equalTo(25)
		}

		subtitleStackView.snp.makeConstraints { make in
			make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
			make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
			make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30) 
		}
	}

	@objc private func handleLogin() {
		let secondVC = LoginViewController()
		secondVC.modalPresentationStyle = .fullScreen
		self.navigationController?.pushViewController(secondVC, animated: true)
	}
}
