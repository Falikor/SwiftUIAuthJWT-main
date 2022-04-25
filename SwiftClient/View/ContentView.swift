//
//  ContentView.swift
//  SwiftClient
//
//  Created by Mohammad Azam on 4/13/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var accountListVM = AccountListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Spacer()
                        Image(systemName: loginVM.isAuthenticated ? "lock.fill": "lock.open")
                    }
                    TextField("Логин", text: $loginVM.email)
                    SecureField("Пароль", text: $loginVM.password)
                    HStack {
                        Spacer()
                        Button("Войти") {
                            loginVM.login()
                        }
                        Button("Сбросить") {
                            loginVM.signout()
                        }
                        .foregroundColor(.red)
                        Spacer()
                    }
                }.buttonStyle(PlainButtonStyle())
            }
        }
        .onAppear(perform: {
            
        })
        .onTapGesture {
            hideKeyboard()
        }
        .navigationTitle("Аунтификация")
        .embedInNavigationView()
        .navigate(to: FirstPage(), when: $loginVM.isAuthenticated)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
