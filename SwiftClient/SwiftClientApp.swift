//
//  SwiftClientApp.swift
//  SwiftClient
//
//  Created by 19494115 on 27.02.2022.
//

import SwiftUI

@main
struct SwiftClientApp: App {
    @StateObject var exampleVM = ExampleOfProgressViewModels()
    var body: some Scene {
        WindowGroup {
              TabViewApp()
            //
        
           //  ContentView()
            // ContentView()
           //   FirstPage()
           // ExampleOfProgress()
        }
    }
}
