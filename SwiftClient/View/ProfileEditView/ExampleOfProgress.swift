//
//  ExampleOfProgress.swift
//  SwiftClient
//
//  Created by 19494115 on 25.03.2022.
//

import SwiftUI

struct ExampleOfProgress: View {
    @State var value = 1
    @StateObject private var exampleVM = ExampleOfProgressViewModels()
    @State private var info: String = ""
    
    var maximum = 6
    var body: some View {
        VStack() {
        VStack(alignment: .leading) {
            SegmentedProgressView(value: value, maximum: maximum)
                .padding(.vertical)
            Text(getString())
                .frame(alignment: .leading)
            if self.value == 1 {
                foto
            } else if self.value == 2 {
                hobbi
            }
            Spacer()
        }
        .padding()
        Button(action: {
            if self.value != 6 {
                self.value = (self.value + 1) % (self.maximum + 1)
            } else {
                exampleVM.isAuthenticated = true
            }
        }) {
            if self.value != 6 {
                Text("Продолжить")
            } else {
                Text("Готово")
            }
        }
        .frame(height: 30, alignment: .center)
        .foregroundColor(.white)
        .padding(.all)
        .background(Color.blue)
        .cornerRadius(16)
        }
        .navigate(to: TabViewApp(), when: $exampleVM.isAuthenticated)
    }
    
    var foto: some View {
        Button {
            print("фото загрузил")
        } label: {
            Image("pluse")
        }

    }
    
    var hobbi: some View {
        TextEditor(text: $info)
            .lineLimit(20)
            .frame(width: 345, height: 189, alignment: .leading)
            .padding()
            .shadow(radius: 1)
    }
    
    func getString() -> String {
        switch value {
        case 1:
            return "Твое фото"
        case 2:
            return "Хобби"
        case 3:
            return "Опыт работы"
        case 4:
            return "Компетенции"
        case 5:
            return "Публикации"
        case 6:
            return "Награды и достижения"
        default:
            return "Твое фото"
        }
    }
}
