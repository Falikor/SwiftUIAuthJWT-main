//
//  History.swift
//  SwiftClient
//
//  Created by 19494115 on 09.04.2022.
//

import Foundation

// MARK: - AccountЕ
struct History: Decodable {
    let id: Int?
    let description, date: String?
    let value: Int?
}
