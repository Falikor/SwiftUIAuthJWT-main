//
//  ProfileView.swift
//  SwiftClient
//
//  Created by 19494115 on 19.03.2022.
//

import SwiftUI
import UIKit

// ячейка для опыта и достижений
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

// ячейка для списков



struct ProfileView: View {
    @StateObject var exampleVM = ExampleOfProgressViewModels()
    @StateObject var postViewModel = ProgressViewModels()
    @State var isActivated: Bool = false
    @State var isActivatedHobby: Bool = false
    @State var isActivatedHardSkills: Bool = false
    @State var isActivatedSoftSkills: Bool = false
    @State var isActivatedSoftPublic: Bool = false
    @State var isActivatedAchivment: Bool = false
    @State var showImagePicker: Bool = false
    @State var image: Image?
    @State var selectedItem: WorkExperienceDTO = WorkExperienceDTO.init(id: nil, position: nil, responsibilities: nil, company: nil, beginningOfWork: nil, endingOfWork: nil)
    @State var selectedItemPublisht: PublicationDTO = PublicationDTO.init(id: nil, link: nil, authors: nil, articleName: nil, publicationDate: nil, journal: nil)
    
    var body: some View {
        
        List {
            Group {
            person
            Divider()
            }
            Group {
            infoForPerson
            Divider()
            }
            // MARK: Хобби
            Group {
            hobby
            }
            // MARK: Опыт работы
            Group {
                Divider()
            HStack(spacing: 5) {
                Image(uiImage: UIImage(named: "icon_profil")!)
                Text("Опыт работы")
                    .font(.headline)
            }
            ForEach(exampleVM.accounts?.workExperienceDTO ??
                    [WorkExperienceDTO.init(id: nil,
                                            position: nil,
                                            responsibilities: nil,
                                            company: nil,
                                            beginningOfWork: nil,
                                            endingOfWork: nil)], id: \.id) { dataItem in
                Button {
                    selectedItem = dataItem
                    isActivated = true
                } label: {
                    VStack(alignment: .leading) {
                        Text(dataItem.company ?? "Название компании")
                            .font(.headline)
                        Text(dataItem.position ?? "Должность")
                    }.padding(7)
                }
            }.onDelete(perform: deleteWorck)
                                            .background(
                                                NavigationLink(destination: ExperienceView(workExperienceDTO: selectedItem, exampleVM: exampleVM),
                                                               isActive: $isActivated) {EmptyView()}.opacity(0)
                                            )
            Button {
                exampleVM.accounts?.workExperienceDTO?.append(WorkExperienceDTO.init(id: nil, position: nil, responsibilities: nil, company: nil, beginningOfWork: nil, endingOfWork: nil))
            } label: {
                HStack {
                    Image(uiImage: UIImage(named: "add_plue")!)
                    Text("Добавить место работы")
                }
            }
            .padding(.horizontal, 30)
                Divider()
            }
            
            // MARK: Soft-skills работы
            
            softSkills
            
            // MARK: Hard-skills работы
            
            hardSkills
            
            // MARK: Публикации
            
            Group {
                Divider()
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
                { (dataItem) in
                    
                    Button {
                        selectedItemPublisht = dataItem
                        isActivated = true
                    } label: {
                        VStack(alignment: .leading) {
                            Text(dataItem.articleName ?? "Название статьи")
                                .font(.headline)
                            Text(dataItem.authors ?? "Авторы")
                        }.padding(7)
                    }
                }.onDelete(perform: deletePublic)
                .background(
                    NavigationLink(destination: PublicationView(exampleVM: exampleVM, publications: selectedItemPublisht),
                                   isActive: $isActivatedSoftPublic) {EmptyView()}.opacity(0)
                    )
            Button {
                exampleVM.accounts?.publicationDTO?.append(PublicationDTO.init(id: nil, link: nil, authors: nil, articleName: nil, publicationDate: nil, journal: nil))
            } label: {
                HStack {
                    Image(uiImage: UIImage(named: "add_plue")!)
                    Text("Добавить публикацию")
                }
            }
            .padding(.horizontal, 30)
                Divider()
            }
            
            // MARK: Достижения
            
            achivements
        
        }
        .listStyle(.plain)
        .onAppear {
            UITableView.appearance().separatorColor = .clear
            exampleVM.getPhoto()
            exampleVM.getPostAccount()
        }
    }
    
    var person: some View {
        HStack(alignment: .top) {
            VStack {
                HStack {
                    // загрузга новой картинки
                    Image(systemName: "arrowshape.turn.up.backward.circle")
                    // загрузга новой картинки
                    /*
                    Button {
                        withAnimation {
                            self.showImagePicker.toggle()
                        }
                    } label: {
                        Image(uiImage: ((exampleVM.image ?? UIImage(named: "ilonMask"))!))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(50)
                            .padding()
                    }
                    .sheet(isPresented: $showImagePicker) {
                        OpenGallary(isShown: $showImagePicker, image: $image)
                    }
                    .onDisappear {
                        exampleVM.image = image.asUIImage()
                        postViewModel.getPostImage()
                    }
                    */
                    Image(uiImage: ((exampleVM.image ?? UIImage(named: "ilonMask"))!))
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(50)
                        .padding()
                    
                    Button {
                        exampleVM.getPdfResume()
                    } label: {
                        Image(systemName: "doc.circle")
                    }
                    .sheet(isPresented: $exampleVM.showPdf, content: {
                        WebView(type: .local, url: "\(exampleVM.pdfView!)")
                    })
                    
                }
                Text("\(exampleVM.fullName())").font(Font.title)
            }.padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        
    }
    
    var infoForPerson: some View {
        CellProfileView(title: "Основная информация", subTitle: "\(exampleVM.accounts?.userDTO?.studyGroupName ?? "")", sububTitle: "\(exampleVM.accounts?.userDTO?.specializationName ?? "")")
    }
    
    var hobby: some View {
        Button {
            isActivatedHobby = true
        } label: {
            CellProfileView(title: "Хобби", sububTitle: "\(exampleVM.accounts?.hobby ?? "")")
        }
        .background(
            NavigationLink(destination: HobbyView(exampleVM: exampleVM),
                           isActive: $isActivatedHobby) {EmptyView()}.opacity(0)
        )
    }
    
    var softSkills: some View {
        Button {
            isActivatedSoftSkills = true
        } label: {
            CellProfileView(title: "Soft-skills", sububTitle: exampleVM.allSoftSkills() ?? "")
        }
        .background(
            NavigationLink(destination: SofttSkillsView(exampleVM: exampleVM, tagsTap: exampleVM.getSoftSkils()),
                           isActive: $isActivatedSoftSkills) {EmptyView()}.opacity(0)
        )
    }
    
    var hardSkills: some View {
        Button {
            isActivatedHardSkills = true
        } label: {
            CellProfileView(title: "Hard-skills", sububTitle: exampleVM.allHardSkills() ?? "")
        }
        .background(
            NavigationLink(destination: HardSkillsView(exampleVM: exampleVM, tagsTap: exampleVM.getHardSkils()),
                           isActive: $isActivatedHardSkills) {EmptyView()}.opacity(0)
        )
    }
    
    var achivements: some View {
        Button {
            isActivatedAchivment = true
        } label: {
            CellProfileView(title: "Награды и достижения", sububTitle: "\(exampleVM.accounts?.achievements ?? "")")
        }
        .background(
            NavigationLink(destination: AchievementsView(exampleVM: exampleVM),
                           isActive: $isActivatedAchivment) {EmptyView()}.opacity(0)
        )
    }
    
    private func deleteWorck(with indexSet: IndexSet) {
        indexSet.forEach { exampleVM.accounts?.workExperienceDTO?.remove(at: $0) }
        guard let resultArray = exampleVM.accounts?.workExperienceDTO else { return }
        postViewModel.workExperience.removeAll()
        for i in resultArray {
            postViewModel.workExperience.append(WorkExperience.init(
                position: i.position,
                responsibilities: i.responsibilities,
                company: i.company,
                beginningOfWork: i.beginningOfWork,
                endingOfWork: i.endingOfWork))
        }
        postViewModel.postAccount()
    }
    
    private func deletePublic(with indexSet: IndexSet) {
        indexSet.forEach { exampleVM.accounts?.publicationDTO?.remove(at: $0) }
        guard let resultArray = exampleVM.accounts?.publicationDTO else { return }
        postViewModel.publication.removeAll()
        for i in resultArray {
            postViewModel.publication.append(Publication.init(link: i.link, authors: i.authors, articleName: i.articleName, publicationDate: i.publicationDate, journal: i.journal))
        }
        postViewModel.postAccount()
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


