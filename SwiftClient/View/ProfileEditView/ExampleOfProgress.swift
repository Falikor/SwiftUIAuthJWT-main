//
//  ExampleOfProgress.swift
//  SwiftClient
//
//  Created by 19494115 on 25.03.2022.
//

import SwiftUI

struct tags: View {
    var tags: Array<AllSkill>
    @State var tagsTap: [AllSkill] = []
    @StateObject var exampleVM: ProgressViewModels
    var body: some View {
        HStack {
            ForEach(tags, id: \.self) { tagChose in
                Button(action: {
                    if tagsTap.contains(tagChose) {
                        guard let index = tagsTap.firstIndex(of: tagChose) else { return }
                        tagsTap.remove(at: index)
                        exampleVM.tagsTap.remove(at: index)
                    } else {
                        tagsTap.append(tagChose)
                        exampleVM.tagsTap.append(tagChose)
                    }
                }) {
                    if tagsTap.contains(tagChose) {
                        Text(tagChose.rawValue)
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                            .padding(4)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue)
                            )
                    } else {
                        Text(tagChose.rawValue)
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
}

struct ExampleOfProgress: View {
    @State var value = 1
    @State var tap = false
    @StateObject private var exampleVM = ProgressViewModels()
    @State private var info: String = ""
    //image загрузка из галереи
    @State var showImagePicker: Bool = false
    @State var image: Image?
    
    var skillsSoft = [AllSkill.COMMUNICATIONS, AllSkill.CRITICAL_THINKING, AllSkill.PROJECT_MANAGEMENT]
    var skillsHard = [AllSkill.JAVA, AllSkill.DATA_SET, AllSkill.PYTHON]
    var maximum = 6
    var body: some View {
        NavigationView {
        VStack() {
        VStack(alignment: .leading) {
            SegmentedProgressView(value: value, maximum: maximum)
                .padding(.vertical)
            Text(getString())
                .frame(alignment: .leading)
                .font(.headline)
                .padding(20)
            if self.value == 1 {
                foto
            } else if self.value == 2 {
                hobbi
            } else if self.value == 3 {
                experianse
            } else if self.value == 4 {
                skils
            } else if self.value == 5 {
                publication
            } else if self.value == 6 {
                achievements
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
                exampleVM.getPostImage()
                RootView.change(to: AnyView(TabViewApp()))
            }
        }) {
            if self.value != 6 {
                Text("Продолжить")
            } else {
                Text("Готово")
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(20)
        .padding(.horizontal, 20)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        }
        //.navigate(to: TabViewApp(), when: $exampleVM.isAuthenticated)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    var foto: some View {
        VStack {
            Button(action: {
                withAnimation {
                    self.showImagePicker.toggle()
                }
            }) {
                if image == nil {
                    Image("pluse")
                }
            }
            image?.resizable().frame(width: 100, height: 100)
        }
        .sheet(isPresented: $showImagePicker) {
            OpenGallary(isShown: $showImagePicker, image: $image)
        }
        .onDisappear {
            exampleVM.image = image.asUIImage()
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
        VStack(alignment: .leading) {
            List {
            ForEach(exampleVM.workExperience, id: \.company) { exp in
                Navigator.navigate(.experience(exp, exampleVM), content: {
                    VStack {
                        Text(exp.company ?? "Название компании")
                            .font(.headline)
                        Text(exp.position ?? "Должность")
                    }.padding(7)
                })
            }.onDelete(perform: deleteWorck)
            }
            .listStyle(.plain)
            Button {
                exampleVM.workExperience.append(WorkExperience.init())
            } label: {
                HStack {
                    Image(uiImage: UIImage(named: "add_plue")!)
                    Text("Добавить место работы")
                }
            }
            .padding(.horizontal, 30)
        }
    }
    
    // Компетенции
    var skils: some View {
        VStack(alignment: .leading) {
            Text("Soft-skills")
            tags(tags: skillsSoft, exampleVM: exampleVM)
            Text("Hard-skills")
            tags(tags: skillsHard, exampleVM: exampleVM)
        }
    }
    
    // Опыт работы
    var publication: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(exampleVM.publication, id: \.articleName)  { article in
                    Navigator.navigate(.publications(article, exampleVM), content: {
                        VStack {
                            Text(article.articleName ?? "Название публикации")
                                .font(.headline)
                            Text(article.authors ?? "Автор")
                        }.padding(7)
                    })
                }.onDelete(perform: deletePublic)
            }
            .listStyle(.plain)
            Button {
                exampleVM.publication.append(Publication.init())
            } label: {
                HStack {
                    Image(uiImage: UIImage(named: "add_plue")!)
                    Text("Добавить новую публикацию")
                }
            }
            .padding(.horizontal, 30)
        }
    }
    
    // Награды и достижения
    var achievements: some View {
        TextEditor(text: $exampleVM.achievements)
            .lineLimit(20)
            .frame(width: 330, height: 189, alignment: .leading)
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
    
    private func deleteWorck(with indexSet: IndexSet) {
        indexSet.forEach { exampleVM.workExperience.remove(at: $0) }
    }
    
    private func deletePublic(with indexSet: IndexSet) {
        indexSet.forEach { exampleVM.publication.remove(at: $0) }
    }
}

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
