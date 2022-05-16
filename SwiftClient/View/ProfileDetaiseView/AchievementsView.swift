//
//  AchievementsView.swift
//  SwiftClient
//
//  Created by 19494115 on 04.05.2022.
//

import Foundation
import SwiftUI

struct AchievementsView: View {
    @StateObject var exampleVM: ExampleOfProgressViewModels
    @StateObject var postViewModel = ProgressViewModels()
    @State private var inputText: String = "" //Input text variable
    @State private var wordCounter: Int = 0 //Count the number of words
    
    var body: some View {
        NavigationView {
        VStack() {
        VStack(alignment: .leading) {
            Text("Изменить награды")
                .frame(alignment: .leading)
                .font(.headline)
                .padding(20)
            
            TextEditor(text: $inputText)
                .lineLimit(20)
                .frame(width: 330, height: 189, alignment: .leading)
                .padding()
                .shadow(radius: 1)
        }
        .padding()
            Spacer()
            Button(action: {
                if inputText != exampleVM.accounts?.achievements {
                    postViewModel.achievements = inputText
                    postViewModel.postAccount()
                }
                
            }) {
                    Text("Сохранить")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            inputText = exampleVM.accounts?.achievements ?? ""
        }
    }
    
}

