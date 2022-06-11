//
//  Top.swift
//  SwiftClient
//
//  Created by 19494115 on 12.04.2022.
//

import Foundation

struct Top: Decodable, Equatable {
    let id: Int?
    let email, firstName, lastName: String?
    let cherriesTop: Int?
    let studyGroupName: String?
    let courseNumber: Int?
    let specializationName: String?
    let photoLink: String?
 }


struct OrderUpload: Codable {
    let file: Data
}
