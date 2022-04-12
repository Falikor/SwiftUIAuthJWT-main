//
//  ExampleOfProgressViewModels.swift
//  SwiftClient
//
//  Created by 19494115 on 26.03.2022.
//

import Foundation

class ExampleOfProgressViewModels: ObservableObject {
    
    @Published var accounts: Account?
    @Published var value: String?
    @Published var history: [History?] = []
    @Published var top: [Top?] = []
    @Published var isAuthenticated: Bool = false
    
    func getPostHistory() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        Webservice().getPostHistory(token: token) { (result) in
            switch result {
                case .success(let history):
                    DispatchQueue.main.async {
                        self.history = history
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
    
    func getPostAccount() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        Webservice().getPostAccount(token: token) { (result) in
            switch result {
            case .success(let accounts):
                DispatchQueue.main.async {
                    self.accounts = accounts
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPostTop() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        Webservice().getPostTop(token: token) { (result) in
            switch result {
            case .success(let top):
                DispatchQueue.main.async {
                    self.top = top
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPostSum() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        Webservice().getPostSum(token: token) { (result) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.value = value
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fullName() -> String {
        guard let firstName = accounts?.userDTO?.firstName else { return "" } 
        guard let lastName = accounts?.userDTO?.lastName else { return "" }
        let fullName = firstName + " " + lastName
        return fullName
    }
    
    func fullNameTop(top: Top?) -> String {
        guard let firstName = top?.firstName else { return "" }
        guard let lastName = top?.lastName else { return "" }
        let fullName = firstName + " " + lastName
        return fullName
    }
}
