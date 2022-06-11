//
//  ProjectView.swift
//  SwiftClient
//
//  Created by 19494115 on 05.06.2022.
//

import Foundation
import SwiftUI

struct ProjectView: View {
    var projectExperienceDTO: ProjectExperienceDTO
    @StateObject var exampleVM: ExampleOfProgressViewModels
    @StateObject var postViewModel = ProgressViewModels()
    
    @State private var position: String = ""
    @State private var responsibilities: String = ""
    @State private var project: String = ""
    @State private var beginning: String = ""
    @State private var results: String = ""
    @State private var ending: String = ""
    @State private var dateBigen = Date()
    @State private var dateEnd = Date()
    @State private var today: Bool = false

    var body: some View {
            VStack(alignment: .leading) {
                TextField("\(projectExperienceDTO.project ?? "Название проекта")", text: $project)
                    .padding(10)
                TextField("\(projectExperienceDTO.position ?? "Роль")", text: $position)
                    .padding(10)
                TextField("\(projectExperienceDTO.responsibilities ?? "Результаты работы")", text: $responsibilities)
                    .padding(10)
                DatePicker("\(exampleVM.stingDateFromString(str: projectExperienceDTO.beginning) ?? "Начало работы")", selection: $dateBigen, displayedComponents: .date)
                    .padding(10)
                if !today {
                    DatePicker("\(exampleVM.stingDateFromString(str: projectExperienceDTO.ending) ?? "Окончание работы")", selection: $dateEnd, displayedComponents: .date)
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
                project = projectExperienceDTO.project ?? ""
                position = projectExperienceDTO.position  ?? ""
                responsibilities = projectExperienceDTO.responsibilities ?? ""
                // надо доделать анрап плохо
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                guard let beginWork = projectExperienceDTO.beginning else { return }
                guard let dateBegin = dateFormatter.date(from: beginWork) else { return }
                
                guard let endWork = projectExperienceDTO.ending else { return }
                guard let dateEndSt = dateFormatter.date(from: endWork) else { return }
                dateBigen = dateBegin
                dateEnd = dateEndSt
            }
        
        Spacer()
        Button(action: {
            if project != "" {
                guard let resultArray = exampleVM.accounts?.projectExperienceDTO else { return }
                postViewModel.projectExperience.removeAll()
                for i in resultArray {
                    postViewModel.projectExperience.append(ProjectExperience.init(responsibilities: i.responsibilities, project: i.project, results: i.results, position: i.position, beginning: i.beginning, ending: i.ending))
                }
                let oldElement = ProjectExperience.init(responsibilities: projectExperienceDTO.responsibilities, project: projectExperienceDTO.project, results: projectExperienceDTO.results, position: projectExperienceDTO.position, beginning: projectExperienceDTO.beginning, ending: projectExperienceDTO.ending)
                
                if let index = postViewModel.projectExperience.firstIndex(of: oldElement) {
                    postViewModel.projectExperience.remove(at: index)
                }
                
                postViewModel.projectExperience.append(ProjectExperience.init(
                    responsibilities: responsibilities,
                    project: project,
                    results: results,
                    position: position,
                    beginning: dateBigen.jsonDate(),
                    ending: today
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

