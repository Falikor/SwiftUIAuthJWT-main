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
    @State var isNowLogin: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: UIImage(named: "vich")!)
                    .frame(width: 317, height: 212, alignment: .center)
                Text("Добро пожаловать в ВИШ")
                    .font(.system(size: 20))
                    .foregroundColor(Color.blue)
                    .padding(.bottom, 20)
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
                Button {
                    loginVM.login()
               //     loginVM.loginFistexet()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    if loginVM.isAuthenticated && !loginVM.isFistExet {
                        RootView.change(to: AnyView(FirstPage()))
                    } else if loginVM.isAuthenticated && loginVM.isFistExet {
                        RootView.change(to: AnyView(TabViewApp()))
                    }
                    }
                } label: {
                    Text("Войти")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                }
                
                Button {
                    isNowLogin = true
                } label: {
                    Text("Я не знаю свой логин и/или пароль")
                        .font(.system(size: 16))
                        .foregroundColor(Color.blue)
                }
                .sheetWithDetents(
                    isPresented: $isNowLogin,
                    detents: [.medium()]
                ) {
                    print("The sheet has been dismissed")
                } content: {
                    ForgotPasswordView()
                }
            }
            .listStyle(.plain)
            .state($loginVM.state)
            
        }
        
        .navigationBarHidden(true)
        .onAppear(perform: {
            
        })
        .onTapGesture {
            hideKeyboard()
        }
        .embedInNavigationView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
