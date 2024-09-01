//
//  JeniralResponce.swift
//  ProfileAuthorization
//
//  Created by Татьяна Исаева on 29.08.2024.
//

import Foundation

// Основная структура ответа
struct DashboardResponse: Codable {
	let myProfile: MyProfile
	let myNewNotifications: Int
	let customerDashboard: CustomerDashboard
	let code: Int

	enum CodingKeys: String, CodingKey {
		case myProfile = "my_profile"
		case myNewNotifications = "my_new_notifications"
		case customerDashboard = "customer_dashboard"
		case code
	}
}

struct MyProfile: Codable {
	let id: String
	let name: String
	let shortName: String
	let firstName: String
	let lastName: String
	let secondName: String
	let email: String
	let phone: String
	let photo: String
	let property: String
	let address: String
	let rating: Int

	enum CodingKeys: String, CodingKey {
		case id
		case name
		case shortName = "short_name"
		case firstName = "first_name"
		case lastName = "last_name"
		case secondName = "second_name"
		case email
		case phone
		case photo
		case property
		case address
		case rating
	}
}

struct CustomerDashboard: Codable {
	let date: String
	let notifications: NotificationCount
	let menuItems: [MenuItem]
	let banners: [Banner]
	let services: [Service]
	let navbar: [NavbarItem]

	enum CodingKeys: String, CodingKey {
		case date
		case notifications
		case menuItems = "menu_items"
		case banners
		case services
		case navbar
	}
}

struct Banner: Codable {
	let title: String
	let text: String
	let image: String
	let action: String
	let priority: Int
}

// MARK: - Service
struct Service: Codable {
	let name: String
	let action: String
	let order: Int
}

// Модель для уведомлений
struct NotificationCount: Codable {
	let count: Int
}

// Модель для элементов меню
struct MenuItem: Codable {
	let action: String
	let name: String
	let description: String?
	let arrear: String?
	let amountCoins: Int?

	enum CodingKeys: String, CodingKey {
		case action
		case name
		case description
		case arrear
		case amountCoins = "amount_coins"
	}
}
