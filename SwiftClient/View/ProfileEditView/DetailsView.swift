//
//  DetailsView.swift
//  SwiftClient
//
//  Created by 19494115 on 30.04.2022.
//

import SwiftUI

struct DetailsView: View {
    @StateObject var exampleVM: ProgressViewModels
    var countryItem: WorkExperience
    
    @State private var position: String = ""
    @State private var responsibilities: String = ""
    @State private var company: String = ""
    @State private var beginningOfWork: String = ""
    @State private var endingOfWork: String = ""
    @State private var dateBigen = Date()
    @State private var dateEnd = Date()
    @State private var today: Bool = false
    
    var body: some View {
            VStack(alignment: .leading) {
                TextField("Название компании", text: $company)
                    .padding(10)
                TextField("Должность", text: $position)
                    .padding(10)
                TextField("Обязоности", text: $responsibilities)
                    .padding(10)
                DatePicker("Начало работы", selection: $dateBigen, displayedComponents: .date)
                    .padding(10)
                if !today {
                DatePicker("Окончание работы", selection: $dateEnd, displayedComponents: .date)
                        .padding(10)
                }
                Toggle(isOn: $today) {
                    Text("По настоящие время")
                        .padding(10)
                }
            
            }
            .padding(.horizontal, 30)
            .onTapGesture {
                hideKeyboard()
            }
        
        Spacer()
        Button(action: {
            exampleVM.workExperience.company = company
            exampleVM.workExperience.position = position
            exampleVM.workExperience.responsibilities = responsibilities
            exampleVM.workExperience.beginningOfWork = dateBigen.dayMonthShortYearWithDots()
            exampleVM.workExperience.endingOfWork = today
            ? dateEnd.dayMonthShortYearWithDots()
            : "по н.в."
            
            
        }) {
                Text("Сохранить")
        }
        .frame(height: 30, alignment: .center)
        .foregroundColor(.white)
        .padding(.all)
        .background(Color.blue)
        .cornerRadius(16)
        
    }
}
