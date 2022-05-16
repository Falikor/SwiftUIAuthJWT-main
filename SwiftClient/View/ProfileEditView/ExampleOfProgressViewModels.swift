//
//  ExampleOfProgressViewModels.swift
//  SwiftClient
//
//  Created by 19494115 on 26.03.2022.
//

import Foundation
import UIKit
import Combine
import PDFKit

class ExampleOfProgressViewModels: ObservableObject {
    
    @Published var accounts: Account?
    @Published var value: String?
    @Published var history: [History?] = []
    @Published var top: [Top?] = []
    @Published var isAuthenticated: Bool = false
    @Published var image: UIImage?
    @Published var pdfView: URL?
    @Published var showPdf: Bool = false
    @Published var sendPdf: Bool = false
    
    func getHardSkils() -> [AllSkill] {
        var tagsTaps: [AllSkill] = []
        for i in AllSkill.allCases {
            guard let hardSkils = accounts?.listOfHardSkillsDTOList else { return [] }
            for b in hardSkils {
                if String(describing: i) == b.hardSkill {
                    tagsTaps.append(i)
                }
            }
        }
        return tagsTaps
    }
    
    func getDataStartEndWorck(dto: WorkExperienceDTO?) -> String? {
        guard let start = dto?.beginningOfWork else { return nil}
        guard let end = dto?.endingOfWork else { return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateStart = dateFormatter.date(from: start) else { return nil}
        guard let dateEnd = dateFormatter.date(from: end) else { return nil}
        return "С \(dateStart.dayMonthShortYearWithDots()) по \(dateEnd.dayMonthShortYearWithDots())"
    }
    
    func getDataPublication(dto: PublicationDTO?) -> String? {
        guard let start = dto?.publicationDate else { return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateStart = dateFormatter.date(from: start) else { return nil}
        return "Опубликована \(dateStart.dayMonthShortYearWithDots())"
    }
    
    func stingDateFromString(str: String?) -> String? {
        guard let str = str else { return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateString = dateFormatter.date(from: str) else { return nil}
        return "\(dateString.dayMonthShortYearWithDots())"
    }
    
    func getSoftSkils() -> [AllSkill] {
        var tagsTaps: [AllSkill] = []
        for i in AllSkill.allCases {
            guard let softSkill = accounts?.listOfSoftSkillsDTOList else { return [] }
            for b in softSkill {
                if String(describing: i) == b.softSkill {
                    tagsTaps.append(i)
                }
            }
        }
        return tagsTaps
    }

    
    func getPostHistory() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        
        Webservice().getPostHistory(token: token) { (result) in
            switch result {
                case .success(let history):
                    DispatchQueue.main.async {
                        self.history = history
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
    }
    
    
    
    func getPostAccount() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        Webservice().getPostAccount(token: token) { (result) in
            switch result {
            case .success(let accounts):
                DispatchQueue.main.async {
                    self.accounts = accounts
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPostTop() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        Webservice().getPostTop(token: token) { (result) in
            switch result {
            case .success(let top):
                DispatchQueue.main.async {
                    self.top = top
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPostSum() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        Webservice().getPostSum(token: token) { (result) in
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.value = value
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPhoto() {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        Webservice().getPhoto(token: token) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPdfResume(action: String) {
        
        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        Webservice().getPdfFile(token: token) { (result) in
            switch result {
            case .success(let pdf):
                DispatchQueue.main.async {
                    //pdf
                    self.pdfView = pdf
                    if action == "send" {
                        self.sendPdf = true
                    } else if action == "show" {
                        self.showPdf = true
                    }
                    print("success")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func allSoftSkills() -> String? {
        var stringArray: [String] = []
        guard let skills = accounts?.listOfSoftSkillsDTOList else { return nil}
        var tagsTaps: [AllSkill] = []
        for i in AllSkill.allCases {
            for b in skills {
                if String(describing: i) == b.softSkill {
                    tagsTaps.append(i)
                }
            }
        }
        for i in tagsTaps {
            stringArray.append(i.rawValue)
        }
        return stringArray.joined(separator: ", ")
    }
    
    func allHardSkills() -> String? {
        var stringArray: [String] = []
        guard let skills = accounts?.listOfHardSkillsDTOList else { return nil}
        var tagsTaps: [AllSkill] = []
        for i in AllSkill.allCases {
            for b in skills {
                if String(describing: i) == b.hardSkill {
                    tagsTaps.append(i)
                }
            }
        }
        for i in tagsTaps {
            stringArray.append(i.rawValue)
        }
        return stringArray.joined(separator: ", ")
    }
    
    func fullName() -> String {
        guard let firstName = accounts?.userDTO?.firstName else { return "" } 
        guard let lastName = accounts?.userDTO?.lastName else { return "" }
        let fullName = firstName + " " + lastName
        return fullName
    }
    
    func fullNameTop(top: Top?) -> String {
        guard let firstName = top?.firstName else { return "" }
        guard let lastName = top?.lastName else { return "" }
        let fullName = firstName + " " + lastName
        return fullName
    }
}


// Получение изображений асинхронно для топ 5

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString: String) {

        let defaults = UserDefaults.standard
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            return
        }
        guard let string = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: string)
        
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

func imageFromData(_ data:Data) -> UIImage {
    UIImage(data: data) ?? UIImage()
}
