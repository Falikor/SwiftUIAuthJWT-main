//
//  AccountListViewModel.swift
//  SwiftClient
//
//  Created by 19494115 on 27.02.2022.
//

import Foundation

class AccountListViewModel: ObservableObject {
    
    @Published var welcome: [Items?] = []
    @Published var state: ScreenViewState = .loading
    
    func getCalendar(url: String) {
        Webservice().getCalendar(url: url) { (result) in
            switch result {
                case .success(let calendars):
                    DispatchQueue.main.async {
                        let result = calendars.items.filter { map in

                            let dateFormatter = ISO8601DateFormatter()
                            guard let tame = map?.start?.dateTime else {return false}
                            let date = dateFormatter.date(from: tame)
                            let dateNow = Date()
                            if dateNow.isBefore(date!) {
                                return true
                            } else {
                                return false
                            }
                        }
                        self.welcome = result.sorted(by: { ferst, last in
                            let dateFormatter = ISO8601DateFormatter()
                            guard let tameF = ferst?.start?.dateTime else {return false}
                            guard let tameL = ferst?.start?.dateTime else {return false}
                            guard let dateFerst = dateFormatter.date(from: tameF) else {return false}
                            guard let dateLast = dateFormatter.date(from: tameL) else {return false}
                            if dateFerst.isBefore(dateLast) {
                                return true
                            } else {
                                return false
                            }
                        })
                    }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.state = .loaded
                }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    func time(_ str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let date = dateFormatter.date(from: str) else { return Date()}
        return date
    }
}
