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
                Image(uiImage: UIImage(named: "vich")!)
                
                TextField("Логин", text: $loginVM.email)
                    .padding(.horizontal, 30)
                Divider()
                    .padding(.horizontal, 20)
                    .padding()
                SecureField("Пароль", text: $loginVM.password)
                    .padding(.horizontal, 30)
                Divider()
                    .padding(.horizontal, 20)
                    .padding()
                Spacer()
                Button("Войти") {
                    loginVM.login()
                    loginVM.loginFistexet()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
                .padding(.horizontal, 20)
            }
            .listStyle(.plain)
            .navigationBarHidden(true)
        }
        .onAppear(perform: {
            
        })
        .onTapGesture {
            hideKeyboard()
        }
        .embedInNavigationView()
        .navigate(to: FirstPage(), when: $loginVM.isAuthenticated)
        .navigate(to: TabViewApp(), when: $loginVM.isFistExet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
