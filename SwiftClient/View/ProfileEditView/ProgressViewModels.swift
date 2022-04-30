//
//  ProgressViewModels.swift
//  SwiftClient
//
//  Created by 19494115 on 23.04.2022.
//

import Foundation

class ProgressViewModels: ObservableObject {
    // хобби
    var hobby: String = ""
    //Опыт работы
    @Published var workExperience: WorkExperience = WorkExperience.init()
    @Published var position: String = ""
    var responsibilities: String = ""
    var company: String = ""
    var beginningOfWork: String = ""
    var endingOfWork: String = ""
    
    @Published var isAuthenticated: Bool = false
    
    func postAccount() {
        /*
        let publication = [Publication(link: "", authors: "", articleName: "", publicationDate: "", journal: "")]
        let workExperience = [WorkExperience(position: "", responsibilities: "", company: "", beginningOfWork: "", endingOfWork: "")]
        let listOfSoftSkills = [ListOfSoftSkill(softSkill: "")]
        let listOfHardSkills = [ListOfHardSkill(hardSkill: "")]
        let accountsEdit = AccountEdit(hobby: hobby, achievements: "", publication: publication, workExperience: workExperience, listOfSoftSkills: listOfSoftSkills, listOfHardSkills: listOfHardSkills)
        */
        var hobbySend: String? = nil
        var work: [WorkExperience]? = nil
        if hobby != "" {
            hobbySend = hobby
        }
        if workExperience.company != nil {
            work = [workExperience]
        }

        let accountsEdit = AccountEdit(hobby: hobbySend, achievements: nil, publication: nil, workExperience: [WorkExperience.init(position: "test", responsibilities: "test", company: "test", beginningOfWork: "test", endingOfWork: "test")], listOfSoftSkills: nil, listOfHardSkills: nil)
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        Webservice().postAccount(accountsEdit: accountsEdit, token: token) { (result) in
            switch result {
            case .success(let message):
                DispatchQueue.main.async {
                    print(message)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
