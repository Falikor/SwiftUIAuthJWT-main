//
//  File.swift
//  SwiftClient
//
//  Created by 19494115 on 19.03.2022.
//

import SwiftUI

struct TabViewApp: View {
    @State private var selection = 0
    var token = ""
    
    var body: some View {
        TabView(selection: $selection) {
            
            NavigationView {
                ProfileView()
                   // .navigationTitle("Профиль")
                    .navigationBarHidden(true)
            }
            .tabItem {
                Image(uiImage: UIImage(named: "profile")!)
               // Text("Профиль")
            }
            .tag(0)
            
            NavigationView {
                NewsView()
                    .navigationTitle("Новости")
            }
            .tabItem {
                Image(uiImage: UIImage(named: "news")!)
               // Text("Новости")
            }
            .tag(1)
            
            NavigationView {
                CalendarView()
                    .navigationBarHidden(true)
                  //  .navigationTitle("Календарь")
            }
            .tabItem {
                Image(uiImage: UIImage(named: "calendr")!)
                //Text("Календарь")
            }
            .tag(2)
            
            
            NavigationView {
                VichenView()
                    .navigationTitle("ВИШенки")
            }
            .tabItem {
                Image(uiImage: UIImage(named: "achiv")!)
                //Text("ВИШенки")
            }
            .tag(3)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}


struct TabViewApp_Previews: PreviewProvider {
    static var previews: some View {
        TabViewApp()
    }
}
