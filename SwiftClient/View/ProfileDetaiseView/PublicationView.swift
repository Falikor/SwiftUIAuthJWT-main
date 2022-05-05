//
//  PublicationView.swift
//  SwiftClient
//
//  Created by 19494115 on 05.05.2022.
//

import SwiftUI
import Foundation

struct PublicationView: View {
    @StateObject var exampleVM: ExampleOfProgressViewModels
    @StateObject var postViewModel = ProgressViewModels()
    var publications: PublicationDTO
    
    @State public var link: String = ""
    @State public var authors: String = ""
    @State public var articleName: String = ""
    @State public var publicationDate: Date = Date()
    @State public var journal: String = ""
    
    var body: some View {
            VStack(alignment: .leading) {
                TextField("\(publications.articleName ?? "Название статьи")", text: $articleName)
                    .padding(10)
                TextField("\(publications.authors ?? "Авторы")", text: $authors)
                    .padding(10)
                TextField("\(publications.journal ?? "Название журнал")", text: $journal)
                    .padding(10)
                DatePicker("\(publications.publicationDate ?? "Дата публикации")", selection: $publicationDate, displayedComponents: .date)
                    .padding(10)
                TextField("\(publications.publicationDate ?? "URL сылка")", text: $link)
                    .padding(10)
            
            }
            .padding(.horizontal, 30)
            .onTapGesture {
                hideKeyboard()
            }
        
        Spacer()
        Button(action: {
            if articleName != "" {
                guard let resultArray = exampleVM.accounts?.publicationDTO else { return }
                postViewModel.publication.removeAll()
                for i in resultArray {
                    postViewModel.publication.append(Publication.init(link: i.link, authors: i.authors, articleName: i.articleName, publicationDate: i.publicationDate, journal: i.journal))
                }
                let oldElement = Publication.init(link: publications.link, authors: publications.authors, articleName: publications.articleName, publicationDate: publications.publicationDate, journal: publications.journal)
                
                if let index = postViewModel.publication.firstIndex(of: oldElement) {
                    postViewModel.publication.remove(at: index)
                }
                
                postViewModel.publication.append(Publication.init(
                    link: link,
                    authors: authors,
                    articleName: articleName,
                    publicationDate: publicationDate.jsonDate(),
                    journal: journal)
                )
                postViewModel.postAccount()
            }
            
        }) {
                Text("Сохранить")
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .cornerRadius(20)
        .padding(.horizontal, 20)
        
    }
}


