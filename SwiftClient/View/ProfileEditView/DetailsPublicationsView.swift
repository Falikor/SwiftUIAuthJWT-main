//
//  DetailsPublicationsView.swift
//  SwiftClient
//
//  Created by 19494115 on 01.05.2022.
//

import SwiftUI

struct DetailsPublicationsView: View {
    @StateObject var exampleVM: ProgressViewModels
    var publications: Publication
    
    @State public var link: String = ""
    @State public var authors: String = ""
    @State public var articleName: String = ""
    @State public var publicationDate: Date = Date()
    @State public var journal: String = ""
    
    var body: some View {
            VStack(alignment: .leading) {
                TextField("Название статьи", text: $articleName)
                    .padding(10)
                TextField("Авторы", text: $authors)
                    .padding(10)
                TextField("Название журнал", text: $journal)
                    .padding(10)
                DatePicker("Дата публикации", selection: $publicationDate, displayedComponents: .date)
                    .padding(10)
                TextField("URL сылка", text: $link)
                    .padding(10)
            
            }
            .padding(.horizontal, 30)
            .onTapGesture {
                hideKeyboard()
            }
        
        Spacer()
        Button(action: {
            if articleName != "" {
                exampleVM.publication.append(Publication.init(
                    link: link,
                    authors: authors,
                    articleName: articleName,
                    publicationDate: publicationDate.jsonDate(),
                    journal: journal)
                )
                exampleVM.publication.removeAll { articl in
                    if articl.articleName == nil {
                        return true
                    } else {
                        return false
                    }
                }
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

