//
//  ProfileView.swift
//  SwiftClient
//
//  Created by 19494115 on 19.03.2022.
//

import SwiftUI

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
                                Image("ilonMask")
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                    .cornerRadius(30)
                                    .padding()
                                    Text("\(exampleVM.fullName())").font(Font.title)
                            }.padding()

                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        .listRowInsets(EdgeInsets())
                        //.background(Color(UIColor.lightGray))
            
            Section(header: Text("Основная информация")) {
                Text("\(exampleVM.accounts?.userDTO?.studyGroupName ?? "")")
                Text("\(exampleVM.accounts?.userDTO?.specializationName ?? "")")
            }
            
            Section(header: Text("Хобби")) {
                Text("\(exampleVM.accounts?.hobby ?? "")")
            }
            
            Section(header: Text("Опыт работы")) {
                ForEach(exampleVM.accounts?.workExperienceDTO ??
                        [WorkExperienceDTO.init(id: nil,
                                               position: nil,
                                               responsibilities: nil,
                                               company: nil,
                                               beginningOfWork: nil,
                                               endingOfWork: nil)], id: \.id)
                { (text) in
                    Text(text.position ?? "")
                    Text(text.responsibilities ?? "")
                    Text(text.company ?? "")
                    Text(text.beginningOfWork ?? "")
                    Text(text.endingOfWork ?? "")
                }
            }
            
            Section(header: Text("Soft-skills")) {
                ForEach(exampleVM.accounts?.listOfSoftSkillsDTOList ??
                        [ListOfSoftSkillsDTOList.init(id: nil, softSkill: nil)], id: \.id)
                { (text) in
                    Text(text.softSkill ?? "")
                }
            }
            
            Section(header: Text("Hard-skills")) {
                ForEach(exampleVM.accounts?.listOfHardSkillsDTOList ??
                        [ListOfHardSkillsDTOList.init(id: nil, hardSkill: nil)], id: \.id)
                { (text) in
                    Text(text.hardSkill ?? "")
                }
            }
            
            Section(header: Text("Публикации"))  {
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
                    Text(text.link ?? "")
                    Text(text.authors ?? "")
                    Text(text.articleName ?? "")
                    Text(text.publicationDate ?? "")
                    Text(text.journal ?? "")
                }
            }
        }
        .onAppear {
            exampleVM.getPostAccount()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


