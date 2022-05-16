//
//  VichenView.swift
//  SwiftClient
//
//  Created by 19494115 on 19.03.2022.
//

import SwiftUI

struct CustomRowView: View {
    var title: String?
    var specializationName: String?
    var studyGroupName: String?
    var number: Int?
    @ObservedObject var imageLoader: ImageLoader
    @State var image: UIImage = UIImage()
    var count: Int

    init(withURL url: String?, title: String?, specializationName: String?, studyGroupName: String?, number: Int?, count: Int) {
        imageLoader = ImageLoader(urlString: url ?? "")
        self.title = title
        self.specializationName = specializationName
        self.studyGroupName = studyGroupName
        self.number = number
        self.count = count
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("#\(count)")
                    .font(.system(size: 16))
                if let data = imageLoader.data {
                    Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                } else {
                    Circle()
                        .background(Color.blue)
                        .frame(width: 40, height: 40)
                        .cornerRadius(20)
                    
                }
                
                VStack(alignment: .leading){
                    Text(title!)
                    HStack {
                        Text("\(number ?? 0)")
                            .font(.system(size: 16))
                        Image("cherrySmall")
                    }
                }
                .padding(.horizontal, 10)
            }
            Text(specializationName ?? "")
                .font(.system(size: 13))
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(Color.gray)
            Text(studyGroupName ?? "")
                .font(.system(size: 13))
                .foregroundColor(Color.gray)
        }
        .onReceive(imageLoader.didChange) { data in
                    self.image = UIImage(data: data) ?? UIImage()
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
                .padding()
                Spacer(minLength: 40)
                Image("cherry")
                    .frame(width: 118, height: 119)
            }
            .background(Color.white)
            .clipped()
            .cornerRadius(8)
            .shadow(color: Color.black, radius: 5, x: 0, y: 0)
            .padding(.horizontal, 20)
            
            
            HStack{
                Button(action: {
                    showRulse = false
                    showHistori = true
                        }) {
                            Text("История")
                                .font(.body)
                                .frame(alignment: .center)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .foregroundColor(.blue)
                                .padding(.all)
                                .background(Color.white)
                                .cornerRadius(16)
                            
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 0.5)
                                .padding(.leading, 20)
                        )
                        .sheetWithDetents(
                                    isPresented: $showHistori,
                                    detents: [.medium(),.large()]
                                ) {
                                    print("The sheet has been dismissed")
                                } content: {
                                    HistoryView()
                                }

                Button(action: {
                    showHistori = false
                    showRulse = true
                        }) {
                            
                            Text("Правила")
                                .font(.body)
                                .frame(alignment: .center)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .foregroundColor(.blue)
                                .padding(.all)
                                .background(Color.white)
                                .cornerRadius(16)
                            
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 0.5)
                                .padding(.trailing, 20)
                        )
                        .sheetWithDetents(
                                    isPresented: $showRulse,
                                    detents: [.medium(),.large()]
                                ) {
                                    print("The sheet has been dismissed")
                                } content: {
                                    RulseView()
                                }
                
            }
            Spacer()
            List (exampleVM.top , id: \.!.email) { top in
                CustomRowView(
                    withURL: top!.photoLink, title: exampleVM.fullNameTop(top: top),
                    specializationName: top?.specializationName,
                    studyGroupName: top?.studyGroupName,
                    number: top?.cherriesTop,
                    count: (exampleVM.top.firstIndex(of: top) ?? 0) + 1
                )
            }
            .listStyle(.plain)
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
