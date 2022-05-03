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
    case experience(WorkExperience, ProgressViewModels)
    case publications(Publication, ProgressViewModels)
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
        case .experience(let countryItem, let exampleVM):
            return AnyView(NavigationLink(
                destination: DetailsExperienceView(exampleVM: exampleVM, countryItem: countryItem)) {
                content()
            })
        case .publications(let publications, let exampleVM):
            return AnyView(NavigationLink(
                destination: DetailsPublicationsView(exampleVM: exampleVM, publications: publications)) {
                content()
            })
        }
    }
}
