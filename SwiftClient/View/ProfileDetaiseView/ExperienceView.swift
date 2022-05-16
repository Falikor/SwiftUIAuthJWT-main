//
//  ExperienceView.swift
//  SwiftClient
//
//  Created by 19494115 on 05.05.2022.
//

import Foundation
import SwiftUI

struct ExperienceView: View {
    var workExperienceDTO: WorkExperienceDTO
    @StateObject var exampleVM: ExampleOfProgressViewModels
    @StateObject var postViewModel = ProgressViewModels()
    
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
                TextField("\(workExperienceDTO.company ?? "Название компании")", text: $company)
                    .padding(10)
                TextField("\(workExperienceDTO.position ?? "Должность")", text: $position)
                    .padding(10)
                TextField("\(workExperienceDTO.responsibilities ?? "Обязоности")", text: $responsibilities)
                    .padding(10)
                DatePicker("\(exampleVM.stingDateFromString(str: workExperienceDTO.beginningOfWork) ?? "Начало работы")", selection: $dateBigen, displayedComponents: .date)
                    .padding(10)
                if !today {
                    DatePicker("\(exampleVM.stingDateFromString(str: workExperienceDTO.endingOfWork) ?? "Окончание работы")", selection: $dateEnd, displayedComponents: .date)
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
            .onAppear {
                company = workExperienceDTO.company ?? ""
                position = workExperienceDTO.position  ?? ""
                responsibilities = workExperienceDTO.responsibilities ?? ""
                // надо доделать анрап плохо
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let beginWork = workExperienceDTO.beginningOfWork else { return }
                guard let dateBegin = dateFormatter.date(from: beginWork) else { return }
                
                guard let endWork = workExperienceDTO.endingOfWork else { return }
                guard let dateEndSt = dateFormatter.date(from: endWork) else { return }
                dateBigen = dateBegin
                dateEnd = dateEndSt
            }
        
        Spacer()
        Button(action: {
            if company != "" {
                guard let resultArray = exampleVM.accounts?.workExperienceDTO else { return }
                postViewModel.workExperience.removeAll()
                for i in resultArray {
                    postViewModel.workExperience.append(WorkExperience.init(
                        position: i.position,
                        responsibilities: i.responsibilities,
                        company: i.company,
                        beginningOfWork: i.beginningOfWork,
                        endingOfWork: i.endingOfWork))
                }
                let oldElement = WorkExperience.init(position: workExperienceDTO.position, responsibilities: workExperienceDTO.responsibilities, company: workExperienceDTO.company, beginningOfWork: workExperienceDTO.beginningOfWork , endingOfWork: workExperienceDTO.endingOfWork)
                
                if let index = postViewModel.workExperience.firstIndex(of: oldElement) {
                    postViewModel.workExperience.remove(at: index)
                }
                
                postViewModel.workExperience.append(WorkExperience.init(
                    position: position,
                    responsibilities: responsibilities,
                    company: company,
                    beginningOfWork: dateBigen.jsonDate(),
                    endingOfWork: today
                                    ? Date().jsonDate()
                                    : dateEnd.jsonDate()
                ))
                postViewModel.postAccount()
            }
            
            
        }) {
                Text("Сохранить")
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(20)
                .padding(.horizontal, 20)
        }
        
    }
}
