//
//  FirstPage.swift
//  SwiftClient
//
//  Created by 19494115 on 20.03.2022.
//

import SwiftUI

struct FirstPage: View {
    @State var butonTap = false
    var body: some View {
        NavigationView {
        VStack (alignment: .center, spacing: 24) {
                Image("banner")
                    .frame(width: 345, height: 345)
                Text("Заполни анкету и получи \n пять ВИШенок")
                    .font(.system(size: 22))
                Text("Небольшая анкета про твои хобби, навыки\n и успехи поможет университету побольше\n узнать о тебе. Ты сможешь получить 5\n ВИШенок и выгрузить анкету, как резюме")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                Button(action: {
                    RootView.change(to: AnyView(ExampleOfProgress()))
                    butonTap = true
                            
                        }) {
                            
                            Text("Заполнить анкету")
                                .font(.body)
                            
                        }
                        .frame(height: 30, alignment: .center)
                        .foregroundColor(.white)
                        .padding(.all)
                        .background(Color.blue)
                        .cornerRadius(16)
            }
        .navigationBarTitle("")
        .navigationBarHidden(true)
       // .navigate(to: ExampleOfProgress(), when: $butonTap)
        }
    }
}

struct FirstPage_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}
