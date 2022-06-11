//
//  ProgressViewModels.swift
//  SwiftClient
//
//  Created by 19494115 on 23.04.2022.
//

import Foundation
import SwiftUI

class ProgressViewModels: ObservableObject {
    // хобби
    var hobby: String = ""
    // награды
    var achievements: String = ""
    //Опыт работы
    @Published var workExperience: [WorkExperience] = [WorkExperience.init()]
    @Published var publication: [Publication] = [Publication.init()]
    @Published var projectExperience: [ProjectExperience] = [ProjectExperience.init(responsibilities: nil, project: nil, results: nil, position: nil, beginning: nil, ending: nil)]
    @Published var position: String = ""
    var responsibilities: String = ""
    var company: String = ""
    var beginningOfWork: String = ""
    var endingOfWork: String = ""
    var tagsTap: [AllSkill] = []
    @Published var isAuthenticated: Bool = false
    var image: UIImage? = nil
    
    func tagHard() -> [ListOfHardSkill]? {
        var array: [ListOfHardSkill] = []
        for i in tagsTap {
            let tag = i.stringEnum(skills: i.rawValue)
            switch HardSkill(rawValue: i.rawValue) {
            case .PYTHON:
                array.append(ListOfHardSkill(hardSkill: tag))
            case .DATA_SET:
                array.append(ListOfHardSkill(hardSkill: tag))
            case .JAVA:
                array.append(ListOfHardSkill(hardSkill: tag))
            default:
                continue
            }
        }
        return array.isEmpty ? nil : array
    }
    
    func tagSoft() -> [ListOfSoftSkill]? {
        var array: [ListOfSoftSkill] = []
        for i in tagsTap {
            let tag = i.stringEnum(skills: i.rawValue)
            switch SoftSkill(rawValue: i.rawValue) {
            case .COMMUNICATIONS:
                array.append(ListOfSoftSkill(softSkill: tag))
            case .CRITICAL_THINKING:
                array.append(ListOfSoftSkill(softSkill: tag))
            case .PROJECT_MANAGEMENT:
                array.append(ListOfSoftSkill(softSkill: tag))
            default:
                continue
            }
        }
        return array.isEmpty ? nil : array
    }
    
    func postAccount() {
        /*
        let publication = [Publication(link: "", authors: "", articleName: "", publicationDate: "", journal: "")]
        let workExperience = [WorkExperience(position: "", responsibilities: "", company: "", beginningOfWork: "", endingOfWork: "")]
        let listOfSoftSkills = [ListOfSoftSkill(softSkill: "")]
        let listOfHardSkills = [ListOfHardSkill(hardSkill: "")]
        let accountsEdit = AccountEdit(hobby: hobby, achievements: "", publication: publication, workExperience: workExperience, listOfSoftSkills: listOfSoftSkills, listOfHardSkills: listOfHardSkills)
        */
        var hobbySend: String? = nil
        var achiev: String? = nil
        var work: [WorkExperience]? = nil
        var publict: [Publication]? = nil
        var project: [ProjectExperience]? = nil
        if hobby != "" {
            hobbySend = hobby
        }
        if achievements != "" {
            achiev = achievements
        }
        if workExperience.first?.company != nil {
            work = workExperience
        }
        if publication.first?.articleName != nil {
            publict = publication
        }
        if projectExperience.first?.project != nil {
            project = projectExperience
        }
        let hardList = tagHard()
        let softList = tagSoft()
        let accountsEdit = AccountEdit(hobby: hobbySend, achievements: achiev, publication: publict, workExperience: work, listOfSoftSkills: softList, listOfHardSkills: hardList, projectExperience: project)
        
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

    func getPostImage() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        guard let image = image else {
            return
        }
        Webservice().getPostImage(image: image, token: token) { (result) in
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
