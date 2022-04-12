//
//  Route.swift
//  SwiftClient
//
//  Created by 19494115 on 19.03.2022.
//

import SwiftUI

enum Route {
    case geniral(String)
    case createProfil
    case tabView
}

struct Navigator {
    static func navigate<T: View>(_ route: Route, content: () -> T) ->
    AnyView {
        switch route {
            
        case .geniral(let token):
            return AnyView(NavigationLink(
                destination: CalendarView(token: token)) {
                content()
            })
        case .createProfil:
            return AnyView(NavigationLink(
                destination: ExampleOfProgress()) {
                content()
            })
        case .tabView:
            return AnyView(NavigationLink(
                destination: TabViewApp()) {
                content()
            })
        }
    }
}
