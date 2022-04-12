//
//  AccountListViewModel.swift
//  SwiftClient
//
//  Created by 19494115 on 27.02.2022.
//

import Foundation

class AccountListViewModel: ObservableObject {
    
    @Published var welcome: [Items?] = []
    
    
    func getCalendar(url: String) {
        Webservice().getCalendar(url: url) { (result) in
            switch result {
                case .success(let calendars):
                    DispatchQueue.main.async {
                        self.welcome = calendars.items
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
