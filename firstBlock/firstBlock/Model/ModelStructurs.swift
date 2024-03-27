//
//  HelpCategoriesModel.swift
//  UIStage
//
//  Created by Рустем on 02.03.2024.
//

import Foundation

struct HelpCategory: Equatable, Codable {

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
    let secondary1Image: String
    let secondary2Image: String
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

    var dateIntervalString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        let dateInterval = "\(dateFormatter.string(from: dateBegin)) - \(dateFormatter.string(from: dateEnd))"
        if isFinished {
            return "Событие закончилось"
        } else {
            switch days {
            case 1:
                return "Событие заканчивается завтра"
            case 0:
                return "Событие заканчивается сегодня"
            default:
                return "Осталось \(days) дней (\(dateInterval))"
            }
        }
    }
}

struct Participants: Codable, Hashable {

    let name: String
    let photo: String

}
