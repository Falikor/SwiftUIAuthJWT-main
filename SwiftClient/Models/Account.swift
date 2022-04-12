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
    let foto, hobby, achievements: String?
    let publicationDTO: [PublicationDTO]?
    let workExperienceDTO: [WorkExperienceDTO]?
    let listOfSoftSkillsDTOList: [ListOfSoftSkillsDTOList]?
    let listOfHardSkillsDTOList: [ListOfHardSkillsDTOList]?
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
    let id: Int?
    let email, password, firstName, lastName: String?
    let role, status: String?
}

// MARK: - WorkExperienceDTO
struct WorkExperienceDTO: Decodable {
    let id: Int?
    let position, responsibilities, company, beginningOfWork: String?
    let endingOfWork: String?
}
