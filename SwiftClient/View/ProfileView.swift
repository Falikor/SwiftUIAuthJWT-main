//
//  ProfileView.swift
//  SwiftClient
//
//  Created by 19494115 on 19.03.2022.
//

import SwiftUI
import UIKit

struct CellProfileView: View {
    var title: String
    var subTitle: String?
    var sububTitle: String
    
    var body: some View {
    VStack(alignment: .leading) {
        HStack(spacing: 5) {
            Image(uiImage: UIImage(named: "icon_profil")!)
            Text(title)
                .font(.headline)
        }
        .padding(5)
        if let subTitle = subTitle {
            Text(subTitle)
                .padding(5)
        }
        Text(sububTitle)
            .fixedSize(horizontal: false, vertical: true)
            .padding(5)
    }
    .padding(5)
    }
}

struct ProfileView: View {
    @StateObject private var exampleVM = ExampleOfProgressViewModels()
    @State private var firstname: String = ""
    @State private var exp: String = ""
    @State private var soft: String = ""
    @State private var hard: String = ""
    @State private var pablic: String = ""
    @State private var grade: String = ""
    var body: some View {
        
        List {
            HStack(alignment: .top) {
                            VStack {
                                Image(uiImage: ((exampleVM.image ?? UIImage(named: "ilonMask"))!))
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(50)
                                    .padding()
                                    Text("\(exampleVM.fullName())").font(Font.title)
                            }.padding()

                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .listRowInsets(EdgeInsets())
                        //.background(Color(UIColor.lightGray))
            
            CellProfileView(title: "Основная информация", subTitle: "\(exampleVM.accounts?.userDTO?.studyGroupName ?? "")", sububTitle: "\(exampleVM.accounts?.userDTO?.specializationName ?? "")")
            
            CellProfileView(title: "Хобби", sububTitle: "\(exampleVM.accounts?.hobby ?? "")")
            
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    Image(uiImage: UIImage(named: "icon_profil")!)
                    Text("Опыт работы")
                        .font(.headline)
                }
                .padding(5)
                ForEach(exampleVM.accounts?.workExperienceDTO ??
                        [WorkExperienceDTO.init(id: nil,
                                               position: nil,
                                               responsibilities: nil,
                                               company: nil,
                                               beginningOfWork: nil,
                                               endingOfWork: nil)], id: \.id)
                { (text) in
                    Text(text.company ?? "Название компании")
                    .padding(5)
                    Text(text.position ?? "Должность")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(5)
                }
            }
            .padding(5)
            
            CellProfileView(title: "Soft-skills", sububTitle: exampleVM.allSoftSkills() ?? "")
            
            CellProfileView(title: "Soft-skills", sububTitle: exampleVM.allHardSkills() ?? "")
            
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    Image(uiImage: UIImage(named: "icon_profil")!)
                    Text("Публикации")
                        .font(.headline)
                }
                .padding(5)
                ForEach(exampleVM.accounts?.publicationDTO ??
                        [PublicationDTO.init(
                            id: nil,
                            link: nil,
                            authors: nil,
                            articleName: nil,
                            publicationDate: nil,
                            journal: nil
                        )], id: \.id)
                { (text) in
                    Text(text.articleName ?? "Название компании")
                    .padding(5)
                    Text(text.authors ?? "Должность")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(5)
                }
            }
            .padding(5)
            
            CellProfileView(title: "Награды и достижения", sububTitle: "\(exampleVM.accounts?.achievements ?? "")")
        }
        .listStyle(.plain)
        .onAppear {
            exampleVM.getPhoto()
            exampleVM.getPostAccount()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


