//
//  MainProfileViewController.swift
//  ProfileAuthorization
//
//  Created by Татьяна Исаева on 30.08.2024.
//

import UIKit
import SnapKit

final class MainProfileViewController: UIViewController {

	// MARK: - Properties

	let networkManager = LoginController()
	private let activityIndicator = UIActivityIndicatorView(style: .large)

	// MARK: - UI Elements

	private lazy var profileImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(systemName: "brain.head.profile.fill"))
		imageView.layer.cornerRadius = 25
		imageView.clipsToBounds = true
		return imageView
	}()

	private lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.text = "Константин П."
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
		return label
	}()

	private let addressLabel: UILabel = {
		let label = UILabel()
		label.text = "ул. Санитарная 7, кв. 179"
		label.font = UIFont.systemFont(ofSize: 17)
		label.textColor = .white
		return label
	}()

	private let notificationIcon: UIImageView = {
		let imageView = UIImageView(image: UIImage(systemName: "bell.fill"))
		imageView.tintColor = .white
		return imageView
	}()

	private let notificationCountLabel: UILabel = {
		let label = UILabel()
		label.text = "4"
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = .red
		return label
	}()

	private lazy var dateLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.boldSystemFont(ofSize: 26)

		return label
	}()

	private lazy var managementСompanyView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 20
		view.layer.masksToBounds = false // Измените на false, чтобы тени были видны
		view.layer.shadowColor = UIColor.black.cgColor // Цвет тени
		view.layer.shadowOpacity = 0.3 // Прозрачность тени
		view.layer.shadowOffset = CGSize(width: 0, height: 2) // Смещение тени
		view.layer.shadowRadius = 4 // Радиус размытия тени
		return view
	}()

	private lazy var managementСompanyMessagesLabel: UILabel = {
		let label = UILabel()
		label.text = "2 сообщения от УК"
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.textColor = .black
		return label
	}()

	private lazy var managementСompanyIndicator: UIView = {
		let view = UIView()
		view.backgroundColor = .red
		view.layer.cornerRadius = 4
		view.layer.masksToBounds = true
		return view
	}()

	private lazy var serviceContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 20
		view.layer.masksToBounds = true
		return view
	}()

	// РАЗДЕЛ СЧЕТОВ
	private lazy var rentIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "payments")
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 20
		imageView.clipsToBounds = true
		return imageView
	}()

	private lazy var rentTextLabe: UILabel = {
		let label = UILabel()
		label.text = "Квартплата"
		label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
		label.textColor = .black
		return label
	}()

	private lazy var srentSubtitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Оплатить до 15 апреля"
		label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		label.textColor = .gray
		return label
	}()

	private lazy var amountLabel: UILabel = {
		let label = UILabel()
		label.text = "4 523,44 ₽"
		label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
		label.textColor = .black
		label.textAlignment = .right
		return label
	}()

	private lazy var countersIcon: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "counters")
		imageView.contentMode = .scaleAspectFit
		imageView.layer.cornerRadius = 20
		imageView.clipsToBounds = true
		return imageView
	}()

	private lazy var  meterReadingsLabel: UILabel = {
		let label = UILabel()
		label.text = "Показания счётчиков"
		label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
		label.textColor = .black
		return label
	}()

	private lazy var  meterReadingsSubtitle: UILabel = {
		let label = UILabel()
		label.text = "Отправить до 25 апреля"
		label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
		label.textColor = .gray
		return label
	}()

	private lazy var iconsStackView: UIStackView = {
		let dropIcon = UIImageView(image: UIImage(systemName: "drop.fill"))
		let boltIcon = UIImageView(image: UIImage(systemName: "bolt.fill"))
		let thermometerIcon = UIImageView(image: UIImage(systemName: "thermometer"))
		let flameIcon = UIImageView(image: UIImage(systemName: "flame.fill"))

		[dropIcon, boltIcon, thermometerIcon, flameIcon].forEach {
			$0.tintColor = .black
			$0.contentMode = .scaleAspectFit
			$0.snp.makeConstraints { make in
				make.size.equalTo(20)
			}
		}

		let stackView = UIStackView(arrangedSubviews: [dropIcon, boltIcon, thermometerIcon, flameIcon])
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		stackView.spacing = 8
		return stackView
	}()

	private lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsHorizontalScrollIndicator = false
		return scrollView
	}()

	private lazy var insuranceStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 16
		return stackView
	}()

	private lazy var propertyInsuranceView: InsuranceView = {
		let view = InsuranceView()
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.3
		view.layer.shadowOffset = CGSize(width: 0, height: 2)
		view.layer.shadowRadius = 4
		view.layer.masksToBounds = false
		return view
	}()

	private lazy var carInsuranceView: InsuranceView = {
		let view = InsuranceView()

		return view
	}()

	private lazy var camerasView: ServicesView = {
		let view = ServicesView()
		view.servicesLabel.text = "Камеры"
		view.servicesImageView.image = UIImage(systemName:  "camera.fill")
		view.servicesImageView.tintColor = .black
		return view
	}()

	private lazy var barrierView: ServicesView = {
		let view = ServicesView()
		view.servicesLabel.text = "Шлагбаум"
		view.servicesImageView.image = UIImage(systemName: "door.garage.closed.trianglebadge.exclamationmark")
		view.servicesImageView.tintColor = .black
		return view
	}()

	private lazy var offersView: ServicesView = {
		let view = ServicesView()
		view.servicesLabel.text = "Предложения"
		view.servicesImageView.image = UIImage(systemName: "lightbulb.max.fill")
		view.servicesImageView.tintColor = .black
		return view
	}()

	private lazy var servicesStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 8
		stackView.distribution = .fillEqually
		return stackView
	}()

	private lazy var allServicesButton: UIButton = {
		let button = UIButton()
		button.setTitle("Все сервисы", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.backgroundColor = UIColor(red: 255/255.0, green: 191/255.0, blue: 96/255.0, alpha: 1)
		button.layer.cornerRadius = 5
		return button
	}()

	// MARK: - Lifecycle Methods

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red
		setupViews()
		fetchDashboardRequest()
	}

	private func showLoadingIndicator() {
		self.activityIndicator.startAnimating()
		self.activityIndicator.alpha = 0
		UIView.animate(withDuration: 0.3) {
			self.activityIndicator.alpha = 1
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		view.backgroundColor = UIColor(red: 2/255.0, green: 43/255.0, blue: 125/255.0, alpha: 1)
	}

	func transformString(_ input: String) -> String {
		let words = input.split(separator: " ")

		guard words.count >= 2 else {
			return input
		}

		let firstWord = words[0]
		let secondWordFirstLetter = words[1].prefix(1)

		let result = "\(firstWord) \(secondWordFirstLetter)"
		return result
	}


	public func fetchDashboardRequest() {
		DispatchQueue.main.async {
			self.showLoadingIndicator()
		}

		// Выполняем асинхронный запрос на фоне
		DispatchQueue.global().async {
			self.networkManager.fetchDashboard(username: "test_user", password: "123456aB") { [weak self] dashboardResponse in
				guard let self = self else { return }

				// Если получили ошибку при загрузке данных
				guard let dashboardResponse = dashboardResponse else {
					print("Не удалось получить данные дашборда.")

					// Остановим индикатор на главном потоке
					DispatchQueue.main.async {
						self.activityIndicator.stopAnimating()
					}
					return
				}

				// Здесь обновляем UI после получения ответа
				DispatchQueue.main.async { [weak self] in
					self?.activityIndicator.stopAnimating()
					self?.updateUI(with: dashboardResponse)
				}
			}
		}
	}

	private func updateUI(with dashboardResponse: DashboardResponse) {
		DispatchQueue.main.async {
			self.dateLabel.text = dashboardResponse.customerDashboard.date
			self.notificationCountLabel.text = "\(dashboardResponse.myNewNotifications)"

			let profile = dashboardResponse.myProfile
			self.nameLabel.text = self.transformString(profile.name)
			self.addressLabel.text = profile.address

			self.loadImage(from: profile.photo) { [weak self] image in
				DispatchQueue.main.async {
					self?.profileImageView.image = image
				}
			}

			self.updateMenuItems(with: dashboardResponse.customerDashboard.menuItems)
			self.loadBannerImages(from: dashboardResponse.customerDashboard.banners)
		}
	}

	private func updateMenuItems(with menuItems: [MenuItem]) {
		guard !menuItems.isEmpty else { return }

		if menuItems.count > 0 {
			let firstItem = menuItems[0]
			rentTextLabe.text = firstItem.name
			srentSubtitleLabel.text = firstItem.description ?? "Нет описания"
			amountLabel.text = (firstItem.arrear ?? "Нет долга") + " ₽"
		}

		if menuItems.count > 1 {
			let secondItem = menuItems[1]
			meterReadingsLabel.text = secondItem.name
			meterReadingsSubtitle.text = secondItem.description ?? "Нет описания"
		}
	}

	private func loadBannerImages(from banners: [Banner]) {
		guard banners.count > 1 else { return }

		let banner = banners[1]
		loadImage(from: banner.image) { [weak self] image in
			DispatchQueue.main.async {
				self?.propertyInsuranceView.firstImageView.image = image
				self?.carInsuranceView.firstImageView.image = image
			}
		}
	}

	private func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
		guard let url = URL(string: urlString) else {
			completion(nil)
			return
		}

		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil, let image = UIImage(data: data) else {
				completion(nil)
				return
			}
			completion(image)
		}

		task.resume()
	}

	private func setupViews() {
		activityIndicator.center = view.center
		view.addSubview(activityIndicator)

		 func createVerticalStackView(arrangedSubviews: [UIView], spacing: CGFloat) -> UIStackView {
			let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
			stackView.axis = .vertical
			stackView.spacing = spacing
			return stackView
		}

		// Метод для создания горизонтального стека
		 func createHorizontalStackView(arrangedSubviews: [UIView], spacing: CGFloat, alignment: UIStackView.Alignment) -> UIStackView {
			let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
			stackView.axis = .horizontal
			stackView.spacing = spacing
			stackView.alignment = alignment
			return stackView
		}

		// Использование вспомогательных функций для создания стека аренды
		let rentTextStackView = createVerticalStackView(arrangedSubviews: [rentTextLabe, srentSubtitleLabel], spacing: 2)
		let rentStackView = createHorizontalStackView(arrangedSubviews: [rentIcon, rentTextStackView, amountLabel], spacing: 12, alignment: .leading)

		// Использование вспомогательных функций для создания стека счётчиков
		let meterReadingsTextStackView = createVerticalStackView(arrangedSubviews: [meterReadingsLabel, meterReadingsSubtitle], spacing: 2)
		let meterReadingsStackView = createHorizontalStackView(arrangedSubviews: [countersIcon, meterReadingsTextStackView, iconsStackView], spacing: 12, alignment: .leading)

		// Добавление сервисов в servisStackView
		[ camerasView, barrierView, offersView ].forEach { servicesStackView.addArrangedSubview($0) }

		// Добавление элементов на экран
		view.addSubview(profileImageView)
		view.addSubview(nameLabel)
		view.addSubview(addressLabel)
		view.addSubview(notificationIcon)
		view.addSubview(notificationCountLabel)
		view.addSubview(serviceContainerView)
		serviceContainerView.addSubview(dateLabel)
		serviceContainerView.addSubview(managementСompanyView)
		managementСompanyView.addSubview(managementСompanyMessagesLabel)
		managementСompanyView.addSubview(managementСompanyIndicator)
		serviceContainerView.addSubview(rentStackView)
		serviceContainerView.addSubview(meterReadingsStackView)
		scrollView.addSubview(insuranceStackView)
		serviceContainerView.addSubview(scrollView)
		serviceContainerView.addSubview(servicesStackView)
		serviceContainerView.addSubview(allServicesButton)


		profileImageView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
			make.leading.equalTo(view).offset(20)
			make.width.height.equalTo(50)
		}

		nameLabel.snp.makeConstraints { make in
			make.top.equalTo(profileImageView)
			make.leading.equalTo(profileImageView.snp.trailing).offset(15)
		}

		addressLabel.snp.makeConstraints { make in
			make.top.equalTo(nameLabel.snp.bottom).offset(5)
			make.leading.equalTo(nameLabel)
		}

		notificationIcon.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
			make.trailing.equalTo(view).offset(-20)
			make.width.height.equalTo(25)
		}

		notificationCountLabel.snp.makeConstraints { make in
			make.top.equalTo(notificationIcon)
			make.leading.equalTo(notificationIcon.snp.trailing).offset(-10)
		}

		serviceContainerView.snp.makeConstraints { make in
			make.height.equalToSuperview().multipliedBy(0.8)
			make.leading.trailing.equalToSuperview()
			make.bottom.equalToSuperview()
		}

		dateLabel.snp.makeConstraints { make in
			make.top.equalTo(serviceContainerView).offset(16)
			make.leading.equalTo(view).offset(20)
			make.height.equalTo(60)
		}

		managementСompanyView.snp.makeConstraints { make in
			make.top.equalTo(dateLabel.snp.bottom).offset(10)
			make.leading.trailing.equalToSuperview().inset(10)
			make.height.equalTo(60)
		}

		managementСompanyMessagesLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalToSuperview().offset(16)
		}

		managementСompanyIndicator.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.equalTo(managementСompanyMessagesLabel.snp.trailing).offset(8)
			make.width.height.equalTo(8)
			make.trailing.equalToSuperview().offset(-16)
		}

		rentStackView.snp.makeConstraints { make in
			make.top.equalTo(managementСompanyView.snp.bottom).offset(20)
			make.leading.trailing.equalToSuperview().inset(10)
			make.height.equalTo(60)
		}

		meterReadingsStackView.snp.makeConstraints { make in
			make.top.equalTo(rentStackView.snp.bottom).offset(16)
			make.leading.trailing.equalToSuperview().inset(10)
			make.height.equalTo(60)
		}

		insuranceStackView.addArrangedSubview(propertyInsuranceView)
		insuranceStackView.addArrangedSubview(carInsuranceView)

		propertyInsuranceView.snp.makeConstraints { make in
			make.height.equalTo(60)
			make.width.equalTo(290)
		}

		carInsuranceView.snp.makeConstraints { make in
			make.height.equalTo(60)
			make.width.equalTo(290)
		}

		scrollView.snp.makeConstraints { make in
			make.top.equalTo(meterReadingsStackView.snp.bottom).offset(20)
			make.leading.trailing.equalToSuperview().inset(16)
			make.height.equalTo(65)
		}

		insuranceStackView.snp.makeConstraints { make in
			make.top.trailing.bottom.equalToSuperview()
			make.leading.equalToSuperview().offset(4)
			make.height.equalToSuperview()
		}

		servicesStackView.snp.makeConstraints { make in
			make.top.equalTo(scrollView.snp.bottom).offset(20)
			make.leading.trailing.equalToSuperview().inset(10)
			make.height.equalTo(70)
		}

		allServicesButton.snp.makeConstraints { make in
			make.height.equalTo(Sizes.L.height)
			make.top.equalTo(servicesStackView.snp.bottom).offset(20)
			make.leading.trailing.equalToSuperview().inset(8)
		}
	}
}




