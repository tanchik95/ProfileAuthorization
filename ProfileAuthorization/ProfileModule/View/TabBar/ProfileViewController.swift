//
//  ProfileViewController.swift
//  ProfileAuthorization
//
//  Created by Татьяна Исаева on 30.08.2024.
//

import UIKit


final class ProfileViewController: UITabBarController {

	let networkManager = LoginController()

	var navigationMainTitle = ""
	var navigationApplicationsTitle = ""
	var navigationEasyLifeTitle = ""
	var navigationChatTitle = ""
	var navigationContactsTitle = ""

	override func viewDidLoad() {
		super.viewDidLoad()

		// Запрашиваем данные дашборда
		self.networkManager.fetchDashboard(username: "test_user", password: "123456aB") { [weak self] dashboardResponse in
			guard let self = self else { return }

			if let dashboardResponse = dashboardResponse {
				for (index, navItem) in dashboardResponse.customerDashboard.navbar.enumerated() {
					DispatchQueue.main.async {
						switch index {
						case 0:
							self.navigationMainTitle = navItem.name
						case 1:
							self.navigationApplicationsTitle = navItem.name
						case 2:
							self.navigationEasyLifeTitle = navItem.name
						case 3:
							self.navigationChatTitle = navItem.name
						case 4:
							self.navigationContactsTitle = navItem.name
						default:
							break
						}
					}
				}

				// После обновления заголовков, переходим к настройке контроллеров
				DispatchQueue.main.async {
					self.setupTabBarControllers()
				}
			}
		}
	}

	private func setupTabBarControllers() {
		let mainProfileViewController = MainProfileViewController()
		mainProfileViewController.view.backgroundColor = .white
		mainProfileViewController.tabBarItem = UITabBarItem(title: navigationMainTitle, image: UIImage(systemName: "key.horizontal.fill"), tag: 0)

		let secondViewController = UIViewController()
		secondViewController.view.backgroundColor = .white
		secondViewController.tabBarItem = UITabBarItem(title: navigationApplicationsTitle, image: UIImage(systemName: "list.bullet.clipboard.fill"), tag: 1)

		let thirdViewController = UIViewController()
		thirdViewController.view.backgroundColor = .white
		thirdViewController.tabBarItem = UITabBarItem(title: navigationEasyLifeTitle, image: UIImage(systemName: "star.fill"), tag: 2)

		let fourthViewController = UIViewController()
		fourthViewController.view.backgroundColor = .white
		fourthViewController.tabBarItem = UITabBarItem(title: navigationChatTitle, image: UIImage(systemName: "message.badge.fill"), tag: 3)

		let fifthViewController = UIViewController()
		fifthViewController.view.backgroundColor = .white
		fifthViewController.tabBarItem = UITabBarItem(title: navigationContactsTitle, image: UIImage(systemName: "list.clipboard.fill"), tag: 4)

		viewControllers = [
			mainProfileViewController,
			secondViewController,
			thirdViewController,
			fourthViewController,
			fifthViewController
		]
	}
}

