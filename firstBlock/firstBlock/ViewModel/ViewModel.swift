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

    func didStartLoadingCategoriesList()
    func didFinishLoadingCategoriesList(list: [HelpCategory])

}

class HelpViewModel {

    weak var helpViewModelDelegate: HelpViewModelDelegate?

    private let readOperator = ReadOperator()

    func fetchCategories() {
        self.helpViewModelDelegate?.didStartLoadingCategoriesList()
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3, qos: .background) {
            do {
                let list: [HelpCategory] = try self.readOperator.readListFromJSON("HelpCategories")
                DispatchQueue.main.async {
                    self.helpViewModelDelegate?.didFinishLoadingCategoriesList(list: list)
                }
            } catch {
                print("Categories load error: \(error)")
            }
        }
    }

}

protocol EventsViewModelDelegate: AnyObject {

    func didStartLoadingEventsList()
    func didFinishLoadingEventsList()

}

class EventsViewModel {

    init(category: HelpCategory) {
        self.currentCategory = category
    }

    weak var eventsViewModelDelegate: EventsViewModelDelegate?

    private let readOperator = ReadOperator()
    var isFinished = false
    var currentCategory: HelpCategory!
    var eventsList: [Event]!

    func fetchEventsList() {
        eventsList = []
        self.eventsViewModelDelegate?.didStartLoadingEventsList()
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3, qos: .background) {
            do {
                self.eventsList = try self.readOperator.readListFromJSON("Events").filter {
                    $0.category == self.currentCategory && $0.isFinished == self.isFinished }
                DispatchQueue.main.async {
                    self.eventsViewModelDelegate?.didFinishLoadingEventsList()
                }
            } catch {
                print("Events load error: \(error)")
            }
        }
    }

    func toggleFinished(whichButton: Bool) {
        whichButton ? (self.isFinished = true) : (self.isFinished = false)
    }
}
