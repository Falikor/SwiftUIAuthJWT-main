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
    case hobby(ExampleOfProgressViewModels)
    case achievements(ExampleOfProgressViewModels)
    case worckExperience(WorkExperienceDTO, ExampleOfProgressViewModels)
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
        case .hobby(let exampleVM):
            return AnyView(NavigationLink(
                destination: HobbyView(exampleVM: exampleVM)) {
                content()
            })
        case .achievements(let exampleVM):
            return AnyView(NavigationLink(
                destination: AchievementsView(exampleVM: exampleVM)) {
                content()
            })
        case .worckExperience(let workExperienceDTO, let exampleVM):
            return AnyView(NavigationLink(
                destination: ExperienceView(workExperienceDTO: workExperienceDTO, exampleVM: exampleVM)) {
                content()
            })
        }
    }
}
