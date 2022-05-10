//
//  CalendarView.swift
//  SwiftClient
//
//  Created by 19494115 on 27.02.2022.
//

import SwiftUI

struct CalendarView: View {
    
    @StateObject private var accountListVM = AccountListViewModel()
    var colors = ["ШАД-111", "ШАД-112", "ШАД-113", "ШМС-111", "ШТД-111", "ШТА-151", "ШУЦ-151", "ШИМ-111"]
    var token = ""
    @State private var selectedColor = "ШАД-111"
    
    var body: some View {
            VStack {
                Picker("", selection: $selectedColor) {
                    ForEach(colors, id: \.self) { text in
                        Text(text)
                            .onDisappear(perform: {
                                switch text {
                                case "ШАД-111": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shad111@rut.digital/events?key=AIzaSyAlX_gpRSI_SB4FzrRDuXWC3wkhR8_8SyI")
                                case "ШАД-112": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shad112@rut.digital/events?key=AIzaSyCdbVwirC2irWFIcCXPiXtL-a-fE6vPkIo")
                                case "ШАД-113": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shad113@rut.digital/events?key=AIzaSyB0AS7bXi3O_Duzl8yM_l6WWFoysvAOkF8")
                                case "ШМС-111": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shms111@rut.digital/events?key=AIzaSyCKOmSuayEtvOD7pfUciLWYy_hqtXkPB_o")
                                case "ШТД-111": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shtd111@rut.digital/events?key=AIzaSyAzGGcUW_0IfAeF3AHYKohagEmdNEF1W8Y")
                                case "ШТА-151": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shta151@rut.digital/events?key=AIzaSyCdBUP5uTrAJA_lpOkmoyAyHcSv9yeH3KM")
                                case "ШУЦ-151": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shuc151@rut.digital/events?key=AIzaSyA3jchtS5XM25D6bDolZG_7DeVinkSYSmw")
                                case "ШИМ-111": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shim111@rut.digital/events?key=AIzaSyBwJlPlWaMRAcHL89dBnCHSSQUA-M1ji-Y")
                                default:
                                    break
                                }
                            })
                            
                        
                    }
                }
                
                List {
                    ForEach(accountListVM.welcome, id: \.!.summary) { (text) in
                        let date = accountListVM.time(text?.start?.dateTime ?? "")
                            VStack(alignment: .leading) {
                                Text("\(date.dayMonthHoursAsStringYearWithSpaces())")
                                Spacer()
                                Text("\(text?.summary ?? "")")
                            }
                    }
                }.state($accountListVM.state)
                
                Spacer()
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

