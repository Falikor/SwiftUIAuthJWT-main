//
//  Webservice.swift
//  SwiftClient
//
//  Created by 19494115 on 27.02.2022.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let email: String
    let password: String
}

struct TestRequestBody: Codable {
}

struct LoginResponse: Codable {
    let token: String?
    let message: String?
    let success: Bool?
}

class Webservice {
        
    func getAllAccounts(token: String, completion: @escaping (Result<Account, NetworkError>) -> Void) {
        
        guard let url = URL(string: "http://193.17.52.134:80/api/v1/developers/1") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            guard let accounts = try? JSONDecoder().decode(Account.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            print(accounts)
            completion(.success(accounts))
/*
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                print("\(data)")
                do {
                    let jsonDecoder = JSONDecoder()
                    let accounts = try jsonDecoder.decode(Account.self, from: data)
                    print("\(accounts)")
                    completion(.success(accounts))
                }
                catch {
                    print("Чтото не так")
                }
 */
            
        }.resume()
    }
    // MARK: - Google получение календаря
    func getCalendar(url: String, completion: @escaping (Result<Welcome, NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                let calendar = try jsonDecoder.decode(Welcome.self, from: data)
                completion(.success(calendar))
            }
            catch {
                print("Чтото не так")
            }
            
        }.resume()
    }
    
    // MARK: - Логирование получение токена
    func login(email: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        
        guard let url = URL(string: "http://193.17.52.134:80/api/v1/auth/login") else {
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            try? JSONDecoder().decode(LoginResponse.self, from: data)
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = loginResponse.token else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(token))
            
        }.resume()
        
    }
    // MARK: - Получение профиля
    func getPostAccount(token: String, completion: @escaping (Result<Account, NetworkError>) -> Void) {
        
        guard let url = URL(string: "http://193.17.52.134:80/api/v1/resume/my") else {
            completion(.failure(.invalidURL))
            return
        }
        let body = TestRequestBody()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            guard let test = try? JSONDecoder().decode(Account.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            print(test)
            completion(.success(test))
            
        }.resume()
    }
    
    // MARK: - Получение истории ВИШенок
    func getPostHistory(token: String, completion: @escaping (Result<[History], NetworkError>) -> Void) {
        
        guard let url = URL(string: "http://193.17.52.134:80/api/v1/cherries/history") else {
            completion(.failure(.invalidURL))
            return
        }
        let body = TestRequestBody()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            guard let history = try? JSONDecoder().decode([History].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(history))
            
        }.resume()
    }
    
    // MARK: - Получение Top
    func getPostTop(token: String, completion: @escaping (Result<[Top], NetworkError>) -> Void) {
        
        guard let url = URL(string: "http://193.17.52.134:80/api/v1/cherries/top5") else {
            completion(.failure(.invalidURL))
            return
        }
        let body = TestRequestBody()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            guard let top = try? JSONDecoder().decode([Top].self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(top))
            
        }.resume()
    }
    
    // MARK: - Получение колличество вишенок
    func getPostSum(token: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let url = URL(string: "http://193.17.52.134:80/api/v1/cherries/my/sum") else {
            completion(.failure(.invalidURL))
            return
        }
        let body = TestRequestBody()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            guard let value = String(data: data, encoding: .utf8) else {
                    print("data is not in UTF-8")
                    return
                }
            completion(.success(value))
            
        }.resume()
    }
    
    func postAccount(accountsEdit: AccountEdit, token: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let url = URL(string: "http://193.17.52.134:80/api/v1/resume/edit") else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(accountsEdit)

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            guard let value = String(data: data, encoding: .utf8) else {
                    print("data is not in UTF-8")
                    return
                }
            completion(.success(value))
            
        }.resume()
    }
}
