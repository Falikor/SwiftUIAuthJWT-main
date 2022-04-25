//
//  AccountEdit.swift
//  SwiftClient
//
//  Created by 19494115 on 23.04.2022.
//

import Foundation

// MARK: - AccountEdit
struct AccountEdit: Encodable {
    var hobby: String?
    let achievements: String?
    let publication: [Publication]?
    let workExperience: [WorkExperience]?
    let listOfSoftSkills: [ListOfSoftSkill]?
    let listOfHardSkills: [ListOfHardSkill]?
    
    enum CodingKeys: String, CodingKey {
        case hobby
        case achievements
        case publication
        case workExperience
        case listOfSoftSkills
        case listOfHardSkills
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hobby, forKey: .hobby)
        try container.encode(achievements, forKey: .achievements)
        try container.encode(publication, forKey: .publication)
        try container.encode(workExperience, forKey: .workExperience)
        try container.encode(listOfSoftSkills, forKey: .listOfSoftSkills)
        try container.encode(listOfHardSkills, forKey: .listOfHardSkills)
    }
}

// MARK: - ListOfHardSkill
struct ListOfHardSkill: Encodable {
    let hardSkill: String?
}

// MARK: - ListOfSoftSkill
struct ListOfSoftSkill: Encodable {
    let softSkill: String?
}

// MARK: - Publication
struct Publication: Encodable {
    let link, authors, articleName, publicationDate: String?
    let journal: String?
    
    enum CodingKeys: String, CodingKey {
        case link
        case authors
        case articleName
        case publicationDate
        case journal
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(link, forKey: .link)
        try container.encode(authors, forKey: .authors)
        try container.encode(articleName, forKey: .articleName)
        try container.encode(publicationDate, forKey: .publicationDate)
        try container.encode(journal, forKey: .journal)
    }
}

// MARK: - WorkExperience
struct WorkExperience: Encodable {
    let position, responsibilities, company, beginningOfWork: String?
    let endingOfWork: String?
    
    enum CodingKeys: String, CodingKey {
        case position
        case responsibilities
        case company
        case beginningOfWork
        case endingOfWork
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(position, forKey: .position)
        try container.encode(responsibilities, forKey: .responsibilities)
        try container.encode(company, forKey: .company)
        try container.encode(beginningOfWork, forKey: .beginningOfWork)
        try container.encode(endingOfWork, forKey: .endingOfWork)
    }
}
