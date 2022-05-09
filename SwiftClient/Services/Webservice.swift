//
//  Webservice.swift
//  SwiftClient
//
//  Created by 19494115 on 27.02.2022.
//

import Foundation
import UIKit
import Alamofire
import PDFKit

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
        guard let jsonData = try? JSONEncoder().encode(accountsEdit) else {
                    print("Error: Trying to convert model to JSON data")
                    return
                }
        let encoder = JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let data = try? encoder.encode(accountsEdit)
        
        if let jsonString = String(data: data!, encoding: .utf8) {
            print(jsonString)
          }
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
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
    
    // MARK: - Получение фото в резюме
    func getPostImage(image: UIImage, token: String, completion: @escaping (Result<String, NetworkError>) -> Void) {

        let headers: HTTPHeaders = [
                    "Authorization": "\(token)",
                    "Content-type": "multipart/form-data"
                ]
        // проверка на то что image хоть какойто есть так как по дефолту image не nil
        if image.size.height == .zero {
            return
        }
        guard let imageNewSize = image.image(scaledTo: .init(width: 300, height: 300)) else {return}
        guard let imageData = imageNewSize.jpegData(compressionQuality: 0.0) else {return}
        // application/form-data
      //  let parameters: [String: String] = ["file": "value"]
        AF.upload(
                        multipartFormData: { multipartFormData in
                            multipartFormData.append(imageData, withName: "file" , fileName: "Elon_Musk_Royal_Society.jpeg", mimeType: "image/jpeg")
                    },
                        to: "http://193.17.52.134:80/api/v1/editPhoto", method: .post , headers: headers)
                        .response { resp in
                            print(resp)

                    }
    }
    
    
    
    static func getPostString(params:[String:Any]) -> String
        {
            var data = [String]()
            for(key, value) in params
            {
                data.append(key + "=\(value)")
            }
            return data.map { String($0) }.joined(separator: "&")
        }
    
    // MARK: - Получение фото
    func getPhoto(token: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let url = URL(string: "http://193.17.52.134:80/api/v1/showPhoto") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            guard let image = UIImage(data: data) else {
                    print("data is not in UTF-8")
                    return
                }
            completion(.success(image))
            
        }.resume()
    }
    
    // MARK: - Первый ли вход?
    func getFistExit(token: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        guard let url = URL(string: "http://193.17.52.134:80/api/v1/resume/first_enter") else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            guard let string = String(data: data, encoding: .utf8) else {
                print("data is not in UTF-8")
                return
            }
            completion(.success(string))
            
        }.resume()
    }
    
    func getPdfFile (token: String, completion: @escaping (Result<URL?, NetworkError>) -> Void) {
        
        
        let headers: HTTPHeaders = [
            "Authorization": "\(token)",
            "Accept": "application/pdf",
            "Content-Type": "application/pdf",
        ]
        
        let destination: DownloadRequest.Destination = { _ , _ in
                    
                    let documentURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                    
                    let fileURL = documentURLs.appendingPathComponent("RandomFile\(Int.random(in: 1..<10000)).pdf")
                    return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
                    
                }
                
        AF.download(URL(string: "http://193.17.52.134:80/api/v1/pdf/resume")!, method: .get, headers: headers, to: destination).downloadProgress(closure: { (progress) in
                    
                }).validate()
                    .response {response in
                        
                        if response.error == nil {
                            debugPrint(response)
                         //   completion(nil)
                            completion(.success(response.fileURL))
                        }
                        else {
                            print("error")
                           // completion(response.error)
                        }
                    }
    }
    
}

extension Encodable {
    func toJSONData() throws -> Data {
        try JSONEncoder().encode(self)
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}


import Foundation

struct MultipartFormDataRequest {
    private let boundary: String = UUID().uuidString
    var httpBody = NSMutableData()
    let url: URL
    let token: String
    init(url: URL, token: String) {
        self.url = url
        self.token = token
    }
    
    func addTextField(named name: String, value: String) {
        httpBody.appendString(textFormField(named: name, value: value))
    }
    
    private func textFormField(named name: String, value: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "Content-Type: text/plain; charset=ISO-8859-1\r\n"
        fieldString += "Content-Transfer-Encoding: 8bit\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        
        return fieldString
    }
    
    
    func addDataField(fieldName: String, fileName: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(fieldName: fieldName,fileName:fileName,data: data, mimeType: mimeType))
    }
    
    private func dataFormField(fieldName: String,
                               fileName: String,
                               data: Data,
                               mimeType: String) -> Data {
        let fieldData = NSMutableData()
        
        fieldData.appendString("--\(boundary)\r\n")
        fieldData.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; name=\"\(fileName)\"\r\n")
        fieldData.appendString("Content-Type: \(mimeType)\r\n")
        fieldData.appendString("\r\n")
        fieldData.append(data)
        fieldData.appendString("\r\n")
        return fieldData as Data
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        httpBody.appendString("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}


extension URLSession {
    func dataTask(with request: MultipartFormDataRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
    -> URLSessionDataTask {
        return dataTask(with: request.asURLRequest(), completionHandler: completionHandler)
    }
}
