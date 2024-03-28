//
//  TableViewController.swift
//  firstBlock
//
//  Created by Рустем on 21.03.2024.
//

import UIKit
import SnapKit

class EventsTableViewController: UIViewController {

    var eventsViewModel: EventsViewModel!
    var categories: [HelpCategory]!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setupNavigationBar()
        self.navigationItem.title = self.eventsViewModel.currentCategory.name
        addFilterButton(menu: filterButtonPressed())

        loadQueue()
    }

    private var readOperator = ReadOperator()

    private lazy var headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = .white
        return headerView
    }()

    private lazy var buttonStackView: UIStackView = {
        let buttonStackView = UIStackView()

        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 0
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        buttonStackView.clipsToBounds = true

        buttonStackView.layer.cornerRadius = 4.0
        buttonStackView.layer.borderWidth = 1.0
        buttonStackView.layer.borderColor = UIColor.leaf.cgColor

        switcherColors()

        buttonStackView.addArrangedSubview(notFinishedButton)
        buttonStackView.addArrangedSubview(finishedButton)

        return buttonStackView
    }()

    private lazy var finishedButton: UIButton = {
        let finishedButton = UIButton()
        finishedButton.setTitle("Завершенные", for: .normal)
        finishedButton.titleLabel?.font = .textStyle9
        finishedButton.addTarget(self, action: #selector(finishedButtonPressed), for: .touchUpInside)
        return finishedButton
    }()

    private lazy var notFinishedButton: UIButton = {
        let notFinishedButton = UIButton()
        notFinishedButton.setTitle("Текущие", for: .normal)
        notFinishedButton.titleLabel?.font = .textStyle9
        notFinishedButton.addTarget(self, action: #selector(notFinishedButtonPressed), for: .touchUpInside)
        return notFinishedButton
    }()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EventPreview.self, forCellReuseIdentifier: EventPreview.identifier)
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = true
        return tableView
    }()

    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        return activityIndicatorView
    }()

}

private extension EventsTableViewController {

    func loadQueue() {
        eventsViewModel.eventsViewModelDelegate = self
        eventsViewModel.fetchEventsList()
    }

    func loadActivityIndicator() {
        view.backgroundColor = .lightGrey
        view.addSubview(activityIndicatorView)

        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(357)
        }

        activityIndicatorView.startAnimating()
    }

    func loadCustomView() {
        view.backgroundColor = .lightGrey

        view.addSubview(headerView)
        view.addSubview(tableView)
        headerView.addSubview(buttonStackView)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .lightGrey
        tableView.separatorStyle = .none

        headerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0))
            make.height.equalTo(43)
        }

        buttonStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        }
    }

    func filterButtonPressed() -> UIMenu {
        var menuChildrens: [UIMenuElement] = []
        for category in self.categories {
            menuChildrens.append(UIAction(title: category.name) { _ in
                self.eventsViewModel.currentCategory = category
                self.navigationItem.title = self.eventsViewModel.currentCategory.name
                self.eventsViewModel.fetchEventsList()
            })
        }
        return UIMenu(children: menuChildrens)
    }

    @objc func finishedButtonPressed() {
        self.eventsViewModel.toggleFinished(whichButton: true)
        switcherColors()
        eventsViewModel.fetchEventsList()
    }

    @objc func notFinishedButtonPressed() {
        self.eventsViewModel.toggleFinished(whichButton: false)
        switcherColors()
        eventsViewModel.fetchEventsList()
    }

    func switcherColors() {
        notFinishedButton.setTitleColor(self.eventsViewModel.isFinished ? .leaf : .white, for: .normal)
        finishedButton.setTitleColor(self.eventsViewModel.isFinished ? .white : .leaf, for: .normal)
        finishedButton.backgroundColor = self.eventsViewModel.isFinished ? .leaf : .white
        notFinishedButton.backgroundColor = self.eventsViewModel.isFinished ? .white : .leaf
    }

}

extension EventsTableViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        eventsViewModel.eventsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventPreview.identifier,
                                                       for: indexPath) as? EventPreview else {
            fatalError("Failed to dequeue EventPreviewReusableView in HelpC")
        }
        cell.configure(event: eventsViewModel.eventsList[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let spacing: CGFloat = 10
        let cellHeight = view.frame.width / 375 * 413
        return cellHeight + spacing
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventDetail = EventDetailViewController()
        eventDetail.event = eventsViewModel.eventsList[indexPath.row]
        navigationController?.pushViewController(eventDetail, animated: true)
    }

}

extension EventsTableViewController: EventsViewModelDelegate {

    func didStartLoadingEventsList() {
        tableView.reloadData()
        loadActivityIndicator()
    }

    func didFinishLoadingEventsList() {
        tableView.reloadData()
        loadCustomView()
    }

}
