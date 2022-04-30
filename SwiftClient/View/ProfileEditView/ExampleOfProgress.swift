//
//  ExampleOfProgress.swift
//  SwiftClient
//
//  Created by 19494115 on 25.03.2022.
//

import SwiftUI

struct tags: View {
    var tags: Array<String>
    var body: some View {
        HStack {
            ForEach(tags, id: \.self) { e in
                Button(action: {
    
                }) {
                    Text(e)
                        .foregroundColor(.blue)
                        .font(.system(size: 14))
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 0.5)
                        )
                }
            }
        }
    }
}

struct ExampleOfProgress: View {
    @State var value = 1
    @State var tap = false
    @StateObject private var exampleVM = ProgressViewModels()
    @State private var info: String = ""
    var skills = ["Java", "Swift", "JS"]
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
            } else if self.value == 3 {
                experianse
            } else if self.value == 4 {
                skils
            }
            Spacer()
        }
        .padding()
        Button(action: {
            if self.value != 6 {
                self.value = (self.value + 1) % (self.maximum + 1)
            } else {
                exampleVM.isAuthenticated = true
                exampleVM.postAccount()
                RootView.change(to: AnyView(TabViewApp()))
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
        //.navigate(to: TabViewApp(), when: $exampleVM.isAuthenticated)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    var foto: some View {
        Button {
            print("фото загрузил")
        } label: {
            Image("pluse")
        }

    }
    // Экран хобби
    var hobbi: some View {
        TextEditor(text: $exampleVM.hobby)
            .lineLimit(20)
            .frame(width: 330, height: 189, alignment: .leading)
            .padding()
            .shadow(radius: 1)
    }
    // Опыт работы
    var experianse: some View {
        List {
            Navigator.navigate(.company(exampleVM.workExperience, exampleVM), content: {
                VStack {
                    Text(exampleVM.workExperience.company ?? "Название коании")
                        .font(.headline)
                    Text(exampleVM.workExperience.position ?? "Должность")
                }.padding(7)
            })
        }
        .listStyle(.plain)
    }
    
                            /*
        VStack {
            Navigator.navigate(.company(exampleVM.workExperience.first), content: {
                VStack {
                Text("Название компании")
                Text("должность")
                }
            })
        }
        }
                             
                             NavigationView {
                             List(exampleVM.workExperience) { work in
                                 NavigationLink {
                                     DetailsView(countryItem: work)
                                 } label: {
                                     VStack {
                                         Text(work.company ?? "Название коании")
                                             .font(.headline)
                                         Text(work.position ?? "Должность")
                                     }.padding(7)
                                 }
                             }
                             }
                             */
    
    // Компетенции
    var skils: some View {
        VStack{
                tags(tags: skills)
        }
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

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
