//
//  VichenView.swift
//  SwiftClient
//
//  Created by 19494115 on 19.03.2022.
//

import SwiftUI

struct CustomRowView: View {
    var title: String
    var number: Int?
    var body: some View {
        HStack {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(.green)
            VStack(alignment: .leading){
                Text(title)
                HStack {
                    Text("\(number ?? 0)")
                    Image("cherrySmall")
                }
            }
            .padding(.horizontal, 10)
        }
    }
}

struct VichenView: View {
    @StateObject private var exampleVM = ExampleOfProgressViewModels()
    @State private var showHistori = false
    @State private var showRulse = false
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("У тебя на счету")
                        .foregroundColor(.blue)
                        .font(.system(size: 14))
                    Text("\(exampleVM.value ?? "0")")
                        .foregroundColor(.blue)
                        .font(.system(size: 60))
                }
                Spacer(minLength: 40)
                Image("cherry")
                    .frame(width: 118, height: 119)
                    .padding(.all)
            }
            .shadow(radius: 20)
            .padding(.horizontal, 30)
            HStack{
                Button(action: {
                    showHistori = true
                        }) {
                            Text("История")
                                .font(.body)
                            
                        }
                        .frame(height: 30, alignment: .center)
                        .foregroundColor(.blue)
                        .padding(.all)
                        .background(Color.white)
                        .cornerRadius(16)
                        .sheet(isPresented: $showHistori, content: {
                            HistoryView()
                        })

                Button(action: {
                    showRulse = true
                        }) {
                            
                            Text("Правила")
                                .font(.body)
                            
                        }
                        .frame(height: 30, alignment: .center)
                        .foregroundColor(.blue)
                        .padding(.all)
                        .background(Color.white)
                        .cornerRadius(16)
                        .sheet(isPresented: $showRulse, content: {
                            RulseView()
                        })
            }
            Spacer()
            List (exampleVM.top, id: \.!.cherriesTop) { top in
                CustomRowView(title: exampleVM.fullNameTop(top: top), number: top?.cherriesTop)
            }
        }
        .onAppear {
            exampleVM.getPostTop()
            exampleVM.getPostSum()
        }
    }
}

struct VichenView_Previews: PreviewProvider {
    static var previews: some View {
        VichenView()
    }
}
