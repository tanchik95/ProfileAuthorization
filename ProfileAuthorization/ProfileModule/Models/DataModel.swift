//
//  JeniralModel.swift
//  ProfileAuthorization
//
//  Created by Татьяна Исаева on 29.08.2024.
//

import Foundation

struct User {
	let username: String
	let password: String
}

struct Dashboard: Codable {
	let profile: Profile
	let notifications: [Notification]
}

struct Profile: Codable {
	let name: String
	let email: String
}

struct Notification: Codable {
	let id: Int
	let title: String
	let message: String
}

// Модель ответа авторизации
struct AuthorizationResponse: Codable {
	let code: Int
	let customerNavbar: [NavbarItem]
	let login: String

	enum CodingKeys: String, CodingKey {
		case code
		case customerNavbar = "customer_navbar"
		case login
	}
}

struct NavbarItem: Codable {
	let action: String
	let name: String
}
