//
//  LoginViewModel.swift
//  SwiftClient
//
//  Created by 19494115 on 27.02.2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var token: String = ""
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        Webservice().login(email: email, password: password) { result in
            switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        self.token = token
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func signout() {
           
           let defaults = UserDefaults.standard
           defaults.removeObject(forKey: "jsonwebtoken")
           DispatchQueue.main.async {
               self.isAuthenticated = false
           }
           
       }
    
}
