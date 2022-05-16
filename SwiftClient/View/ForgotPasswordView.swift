//
//  ForgotPasswordView.swift
//  SwiftClient
//
//  Created by 19494115 on 14.05.2022.
//


import SwiftUI

struct ForgotPasswordView: View {
    
    var body: some View {
            VStack {
                Text("Не знаешь свой логин/пароль?")
                    .font(.system(size: 16))
                    .foregroundColor(Color.blue)
                Text("Обратись в деканат, понадобится ФИО\n и номер твоей зачетки для создания\n или восстановления данных аккаунта ")
                    .font(.system(size: 16))
                
            }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
