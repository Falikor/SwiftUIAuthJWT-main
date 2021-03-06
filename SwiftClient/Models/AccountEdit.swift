//
//  AccountEdit.swift
//  SwiftClient
//
//  Created by 19494115 on 23.04.2022.
//

import Foundation

// MARK: - AccountEdit
struct AccountEdit: Codable {
    var hobby: String?
    var achievements: String?
    var publication: [Publication]?
    var workExperience: [WorkExperience]?
    var listOfSoftSkills: [ListOfSoftSkill]?
    var listOfHardSkills: [ListOfHardSkill]?
    var projectExperience: [ProjectExperience]?
}

// MARK: - ListOfHardSkill
struct ListOfHardSkill: Codable {
    let hardSkill: String?
}

// MARK: - ListOfSoftSkill
struct ListOfSoftSkill: Codable {
    let softSkill: String?
}

// MARK: - Publication
struct Publication: Codable, Equatable {
    var link: String?
    var authors: String?
    var articleName: String?
    var publicationDate: String?
    var journal: String?

}

// MARK: - WorkExperience
struct WorkExperience: Codable, Equatable {
        
    var position: String?
    var responsibilities: String?
    var company: String?
    var beginningOfWork: String?
    var endingOfWork: String?
}

// MARK: - ProjectExperience
struct ProjectExperience: Codable, Equatable {
    let responsibilities, project, results, position: String?
    let beginning, ending: String?
}
