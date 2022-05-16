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
    @Published var firstDate: String = ""
    
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
                        let resultArray = result.sorted { self.time(($1?.start?.dateTime)!) > self.time(($0?.start?.dateTime)!)}
                        self.welcome = resultArray
                        let str = resultArray.first??.start?.dateTime
                        self.firstDate = str ?? ""
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                        self.state = .loaded
                        }
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

extension Date {
    struct MonthDay: Comparable {
        let month: Int
        let day: Int
        
        init(date: Date) {
            let comps = Calendar.current.dateComponents([.month,.day], from: date)
            self.month = comps.month ?? 0
            self.day = comps.day ?? 0
        }
        
        static func <(lhs: MonthDay, rhs: MonthDay) -> Bool {
            return (lhs.month < rhs.month || (lhs.month == rhs.month && lhs.day < rhs.day))
        }
    }
}
