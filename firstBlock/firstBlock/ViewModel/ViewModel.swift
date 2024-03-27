//
//  ViewModel.swift
//  firstBlock
//
//  Created by Рустем on 25.03.2024.
//

import Foundation

class TabBarViewModel {

    let newsViewMovel: String = "NewsViewModel"
    let searchViewModel: String = "StringViewModel"
    let helpViewModel: HelpViewModel
    let historyViewModel: String = "HistoryViewModel"
    let profileViewModel: String = "ProfileViewModel"

    init() {
        self.helpViewModel = HelpViewModel()
    }

}

protocol HelpViewModelDelegate: AnyObject {

    func fetchCategoriesList(list: [HelpCategory])

}

class HelpViewModel {

    weak var helpViewModelDelegate: HelpViewModelDelegate?

    private let readOperator = ReadOperator()

    func fetchCategories() {
        do {
            let list: [HelpCategory] = try self.readOperator.readListFromJSON("HelpCategories")
            self.helpViewModelDelegate?.fetchCategoriesList(list: list)
        } catch {
            print("Categories load error: \(error)")
        }
    }

}

class EventsViewModel {

    init(category: HelpCategory) {
        self.currentCategory = category
    }

    private let readOperator = ReadOperator()
    var isFinished = false
    var currentCategory: HelpCategory!

    var eventsList: [Event] {
        do {
            return try self.readOperator.readListFromJSON("Events").filter {
                $0.category == self.currentCategory && $0.isFinished == self.isFinished }
        } catch {
            print("Events load error: \(error)")
            return []
        }
    }

    func toggleFinished(whichButton: Bool) {
        whichButton ? (self.isFinished = true) : (self.isFinished = false)
    }
}
