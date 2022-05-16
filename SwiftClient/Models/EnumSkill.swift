//
//  EnumSkill.swift
//  SwiftClient
//
//  Created by 19494115 on 01.05.2022.
//

import Foundation

public enum AllSkill: String, CaseIterable {
    case COMMUNICATIONS = "Коммуникация"
    case CRITICAL_THINKING = "Критическое мышление"
    case PROJECT_MANAGEMENT = "Управление проектами"
    
    case JAVA = "Java"
    case PYTHON = "Python"
    case DATA_SET = "Data set"
    
    func stringEnum(skills: String) -> String {
        return String(describing: AllSkill.init(rawValue: skills).unsafelyUnwrapped)
    }
}

public enum SoftSkill: String, CaseIterable {
    case COMMUNICATIONS = "Коммуникация"
    case CRITICAL_THINKING = "Критическое мышление"
    case PROJECT_MANAGEMENT = "Управление проектами"
    
    
    func stringEnum(skills: String) -> String {
        return String(describing: SoftSkill.init(rawValue: skills).unsafelyUnwrapped)
    }
}

public enum HardSkill: String {
    case JAVA = "Java"
    case PYTHON = "Python"
    case DATA_SET = "Data set"
    
    func stringEnum(skills: String) -> String {
        return String(describing: HardSkill.init(rawValue: skills).unsafelyUnwrapped)
    }
}
