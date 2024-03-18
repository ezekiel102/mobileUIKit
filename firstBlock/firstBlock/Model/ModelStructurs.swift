//
//  HelpCategoriesModel.swift
//  UIStage
//
//  Created by Рустем on 02.03.2024.
//

import Foundation

struct HelpCategory: Identifiable, Codable {

    let id: Int
    let name: String
    let imageName: String

}

struct Event: Identifiable, Codable {

    let id: Int
    let title: String
    let category: HelpCategory
    let dateBegin: Date
    let dateEnd: Date
    let owner: String
    let location: String
    let contacts: [String]
    let previewDescription: String
    let description: String
    let link: URL
    let previewImage: String
    let mainImage: String
    let secondaryImage: [String]
    let participants: [Participants]

    var days: Int {
        Int((dateEnd.timeIntervalSince1970 - currentDate.timeIntervalSince1970)/3600/24)
    }

    var currentDate: Date {
        Date()
    }

    var isFinished: Bool {
        currentDate > dateEnd
    }

    var dateInterval: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return "\(dateFormatter.string(from: dateBegin)) - \(dateFormatter.string(from: dateEnd))"
    }
}

struct Participants: Codable, Hashable {

    let name: String
    let photo: String

}
