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
    @State private var dateTodat = Date()
    
    var body: some View {
        VStack {
            HStack {
                Text("Расписание")
                    .font(.system(size: 26))
                Spacer()
                Picker("", selection: $selectedColor) {
                    ForEach(colors, id: \.self) { text in
                        Text(text)
                            .font(.system(size: 16))
                    }
                }
                .onChange(of: selectedColor) { value in
                    switch value {
                    case "ШАД-111": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shad111@rut.digital/events?key=AIzaSyAlX_gpRSI_SB4FzrRDuXWC3wkhR8_8SyI")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dateTodat = accountListVM.time(accountListVM.firstDate)
                        }
                    case "ШАД-112": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shad112@rut.digital/events?key=AIzaSyCdbVwirC2irWFIcCXPiXtL-a-fE6vPkIo")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dateTodat = accountListVM.time(accountListVM.firstDate)
                        }
                    case "ШАД-113": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shad113@rut.digital/events?key=AIzaSyB0AS7bXi3O_Duzl8yM_l6WWFoysvAOkF8")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dateTodat = accountListVM.time(accountListVM.firstDate)
                        }
                    case "ШМС-111": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shms111@rut.digital/events?key=AIzaSyCKOmSuayEtvOD7pfUciLWYy_hqtXkPB_o")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dateTodat = accountListVM.time(accountListVM.firstDate)
                        }
                    case "ШТД-111": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shtd111@rut.digital/events?key=AIzaSyAzGGcUW_0IfAeF3AHYKohagEmdNEF1W8Y")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dateTodat = accountListVM.time(accountListVM.firstDate)
                        }
                    case "ШТА-151": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shta151@rut.digital/events?key=AIzaSyCdBUP5uTrAJA_lpOkmoyAyHcSv9yeH3KM")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dateTodat = accountListVM.time(accountListVM.firstDate)
                        }
                    case "ШУЦ-151": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shuc151@rut.digital/events?key=AIzaSyA3jchtS5XM25D6bDolZG_7DeVinkSYSmw")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dateTodat = accountListVM.time(accountListVM.firstDate)
                        }
                    case "ШИМ-111": accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shim111@rut.digital/events?key=AIzaSyBwJlPlWaMRAcHL89dBnCHSSQUA-M1ji-Y")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            dateTodat = accountListVM.time(accountListVM.firstDate)
                        }
                    default:
                        break
                    }
                    
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 40)
            .padding(.bottom, 40)
            HStack {
                Button {
                    dateTodat -= 86400
                } label: {
                    Image(systemName: "chevron.left")
                }
                Spacer()
                Text("\(dateTodat.shrtDayTitle()) \(dateTodat.dayMonthWithDots())")
                Spacer()
                Button {
                    dateTodat += 86400
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.horizontal, 20)
            
            
            List {
                if accountListVM.welcome.isEmpty {
                    HStack(alignment: .center) {
                    Image(uiImage: UIImage(systemName: "calendar")!)
                    Text("Нет запланированных мероприятий ")
                        .font(.system(size: 18))
                        .frame(alignment: .center)
                    }
                    .listRowBackground(Color(UIColor.clear))
                }
                ForEach(accountListVM.welcome, id: \.!.start?.dateTime) { (text) in
                    let date = accountListVM.time(text?.start?.dateTime ?? "")
                    let dateEnd = accountListVM.time(text?.end?.dateTime ?? "")
                    if date.jsonDate() == dateTodat.jsonDate() {
                        VStack(alignment: .leading) {
                            Text("\(date.hoursMinutseWithSpaces()) - \(dateEnd.hoursMinutseWithSpaces())")
                            Spacer()
                            Text("\(text?.summary ?? "")")
                        }
                        // .listRowBackground(Color(UIColor.systemGray6))
                    }
                }
            }
            .state($accountListVM.state, backgroundColor: .white)
            Spacer()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            accountListVM.getCalendar(url: "https://www.googleapis.com/calendar/v3/calendars/shad111@rut.digital/events?key=AIzaSyAlX_gpRSI_SB4FzrRDuXWC3wkhR8_8SyI")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                dateTodat = accountListVM.time(accountListVM.firstDate)
            }
            selectedColor = "ШАД-111"
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

