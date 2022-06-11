//
//  HistoryView.swift
//  SwiftClient
//
//  Created by 19494115 on 10.04.2022.
//

import SwiftUI

struct CustomHistoryRowView: View {
    var title: String
    var date: String
    var number: Int
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(title)
                Text(date)
            }
            Spacer()
            Text("+ \(number)")
                .foregroundColor(Color.green)
        }
    }
}

struct HistoryView: View {
    var id: Int?
    @StateObject private var exampleVM = ExampleOfProgressViewModels()
    var body: some View {
        List {
            ForEach(exampleVM.history , id: \.!.id) { (history) in
                CustomHistoryRowView(title: history?.description ?? "", date: exampleVM.stingDateFromString(str: history?.date) ?? "", number: history?.value ?? 0)
            }
        }
        .onAppear {
            if let id = id {
                exampleVM.getPostHistoryTop(id: id)
            } else {
                exampleVM.getPostHistory()
            }
        }
    }
}
