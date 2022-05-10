//
//  LoginViewModel.swift
//  SwiftClient
//
//  Created by 19494115 on 27.02.2022.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAuthenticated: Bool = false
    @Published var token: String = ""
    @Published var isFistExet: Bool = false
    @Published var state: ScreenViewState = .loaded
    
    func login() {
        self.state = .loading
        let defaults = UserDefaults.standard
        
        Webservice().login(email: email, password: password) { result in
            switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        self.token = token
                        
                        Webservice().getFistExit(token: token) { (result) in
                            switch result {
                            case .success(let isFistExet):
                                DispatchQueue.main.async {
                                    //pdf
                                    self.isFistExet = Bool(isFistExet) ?? false
                                    print("success")
                                    self.state = .loaded
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                                self.state = .loaded
                            }
                        }

                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self.state = .loaded
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
