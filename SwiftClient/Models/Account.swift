//
//  Account.swift
//  SwiftClient
//
//  Created by 19494115 on 27.02.2022.
//

import Foundation

// MARK: - Account
struct Account: Decodable {
    /*
    let id: Int?
    let firstName: String?
    let lastName: String?
*/
    let id: Int?
    var foto, hobby, achievements: String?
    var publicationDTO: [PublicationDTO]?
    var workExperienceDTO: [WorkExperienceDTO]?
    var listOfSoftSkillsDTOList: [ListOfSoftSkillsDTOList]?
    var listOfHardSkillsDTOList: [ListOfHardSkillsDTOList]?
    let userDTO: UserDTO?
}

// MARK: - ListOfHardSkillsDTOList
struct ListOfHardSkillsDTOList: Decodable {
    let id: Int?
    let hardSkill: String?
}

// MARK: - ListOfSoftSkillsDTOList
struct ListOfSoftSkillsDTOList: Decodable {
    let id: Int?
    let softSkill: String?
}

// MARK: - PublicationDTO
struct PublicationDTO: Decodable {
    let id: Int?
    let link, authors, articleName, publicationDate: String?
    let journal: String?
}

// MARK: - UserDTO
struct UserDTO: Decodable {
    let email, firstName, lastName: String?
    let studyGroupName: String?
    let courseNumber: Int?
    let specializationName: String?
}

// MARK: - WorkExperienceDTO
struct WorkExperienceDTO: Decodable {
    let id: Int?
    let position, responsibilities, company, beginningOfWork: String?
    let endingOfWork: String?
}
