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
                    .navigationTitle("Профиль")
            }
            .tabItem {
                Image(systemName: "person.crop.circle")
                Text("Профиль")
            }
            .tag(0)
            
            NavigationView {
                NewsView()
                    .navigationTitle("Новости")
            }
            .tabItem {
                Image(systemName: "bookmark.circle.fill")
                Text("Новости")
            }
            .tag(1)
            
            NavigationView {
                CalendarView()
                    .navigationTitle("Календарь")
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Календарь")
            }
            .tag(2)
            
            
            NavigationView {
                VichenView()
                    .navigationTitle("Вишетки")
            }
            .tabItem {
                Image(systemName: "video.circle.fill")
                Text("Вишетки")
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
