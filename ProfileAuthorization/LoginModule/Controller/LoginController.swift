//
//  LoginController.swift
//  ProfileAuthorization
//
//  Created by Татьяна Исаева on 29.08.2024.
//

import Foundation

class LoginController {

	let baseURL = "https://test.rozentalgroup.ru/version2/entry.php"

	func authorize(username: String, password: String, completion: @escaping (AuthorizationResponse?) -> Void) {
		let parameters = [
			"service[0][name]": "login",
			"service[0][attributes][login]": username,
			"service[0][attributes][password]": password,
			"service[1][name]": "customer_navbar"
		]

		let request = createRequest(method: "POST", parameters: parameters, username: username, password: password)

		sendRequest(request: request) { (responseData, error) in
			guard error == nil, let responseData = responseData else {
				completion(nil)
				return
			}

			// Попытаемся декодировать данные в AuthorizationResponse
			do {
				let authorizationResponse = try JSONDecoder().decode(AuthorizationResponse.self, from: responseData)
				completion(authorizationResponse)
			} catch {
				print("Ошибка при декодировании ответа авторизации: \(error)")
				completion(nil)
			}
		}
	}

	func fetchDashboard(username: String, password: String, completion: @escaping (DashboardResponse?) -> Void) {
		let parameters = [
			"service[0][name]": "customer_dashboard",
			"service[1][name]": "my_profile",
			"service[2][name]": "my_new_notifications",
			"service[2][attributes][mode]": "private"
		]

		let request = createRequest(method: "POST", parameters: parameters, username: username, password: password)

		sendRequest(request: request) { (responseData, error) in
			guard error == nil, let responseData = responseData else {
				completion(nil)
				return
			}

			// Попытаемся декодировать данные в DashboardResponse
			do {
				let dashboardResponse = try JSONDecoder().decode(DashboardResponse.self, from: responseData)
				completion(dashboardResponse)
			} catch {
				print("Ошибка при декодировании данных дашборда: \(error)")
				completion(nil)
			}
		}
	}

	private func createRequest(method: String, parameters: [String: Any], username: String, password: String) -> URLRequest {
		var request = URLRequest(url: URL(string: baseURL)!)
		request.httpMethod = method

		let boundary = UUID().uuidString
		request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
		addBasicAuthHeader(request: &request, username: username, password: password)

		let body = createBody(with: parameters, boundary: boundary)
		request.httpBody = body

		return request
	}

	private func addBasicAuthHeader(request: inout URLRequest, username: String, password: String) {
		let loginString = "\(username):\(password)"
		let loginData = loginString.data(using: String.Encoding.utf8)!
		let base64LoginString = loginData.base64EncodedString()
		request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
	}

	private func createBody(with parameters: [String: Any], boundary: String) -> Data {
		var body = Data()

		for (key, value) in parameters {
			body.append("--\(boundary)\r\n".data(using: .utf8)!)
			body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
			body.append("\(value)\r\n".data(using: .utf8)!)
		}

		body.append("--\(boundary)--\r\n".data(using: .utf8)!)
		return body
	}

	private func sendRequest(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			completion(data, error)
		}
		task.resume()
	}
}
