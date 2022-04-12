//
//  NewsView.swift
//  SwiftClient
//
//  Created by 19494115 on 19.03.2022.
//

import SwiftUI

struct NewsView: View {
    
    var body: some View {
        WebView(type: .public, url: "https://rut.digital/page26358388.html")
            .navigationBarHidden(true)
            .frame(alignment: .center)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}

