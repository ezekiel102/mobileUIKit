//
//  TabBarController.swift
//  firstBlock
//
//  Created by Рустем on 18.02.2024.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Delegate properties and functions

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    // MARK: - Private constants

    private enum UIConstants {
        static let helpButtonSize: CGFloat = 42
        static let heartImageViewHeightSize: CGFloat = 15
        static let heartImageViewWidthSize: CGFloat = 18

    }

    // MARK: - Private properties

    private lazy var helpButton: UIButton = {
        let helpButton = UIButton()
        helpButton.layer.cornerRadius = UIConstants.helpButtonSize / 2
        helpButton.backgroundColor = .white
        helpButton.layer.shadowColor = UIViewConstants.black20.cgColor
        helpButton.layer.shadowOpacity = 1
        helpButton.layer.shadowOffset = .zero
        helpButton.layer.shadowRadius = 10
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        return helpButton
    }()

    private lazy var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(systemName: "heart.fill")
        heartImageView.tintColor = UIViewConstants.leaf
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()

    // MARK: - Private methods
    private func initialize() {
        tabBar.addSubview(helpButton)
        helpButton.addSubview(heartImageView)
        helpButton.addTarget(self,
                             action: #selector(didPressHelpButton),
                             for: .touchUpInside)

        NSLayoutConstraint.activate([
        helpButton.heightAnchor.constraint(
            equalToConstant: UIConstants.helpButtonSize),
        helpButton.widthAnchor.constraint(
            equalToConstant: UIConstants.helpButtonSize),
        helpButton.centerXAnchor.constraint(
            equalTo: tabBar.centerXAnchor),
        helpButton.topAnchor.constraint(
            equalTo: tabBar.topAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            heartImageView.heightAnchor.constraint(
                equalToConstant: UIConstants.heartImageViewHeightSize),
            heartImageView.widthAnchor.constraint(
                equalToConstant: UIConstants.heartImageViewWidthSize),
            heartImageView.centerXAnchor.constraint(
                equalTo: helpButton.centerXAnchor),
            heartImageView.centerYAnchor.constraint(
                equalTo: helpButton.centerYAnchor)
        ])

        tabBar.tintColor = UIViewConstants.leaf
        tabBar.unselectedItemTintColor = UIViewConstants.warmGrey

        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let newsNC = mainStoryboard.instantiateViewController(
            withIdentifier: "NewsNavigationController")
        let searchNC = mainStoryboard.instantiateViewController(
            withIdentifier: "SearchNavigationController")
        let helpNC = mainStoryboard.instantiateViewController(
                withIdentifier: "HelpNavigationController")
        let historyNC = mainStoryboard.instantiateViewController(
            withIdentifier: "HistoryNavigationController")
        let profileNC = mainStoryboard.instantiateViewController(
            withIdentifier: "ProfileNavigationController")

        viewControllers = [newsNC, searchNC, helpNC, historyNC, profileNC]

        selectedIndex = 2

        newsNC.tabBarItem.title = "Новости"
        newsNC.tabBarItem.image = UIImage(systemName: "list.bullet")

        searchNC.tabBarItem.title = "Поиск"
        searchNC.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        helpNC.tabBarItem.title = "Помочь"

        historyNC.tabBarItem.title = "История"
        historyNC.tabBarItem.image = UIImage(systemName: "clock.arrow.circlepath")

        profileNC.tabBarItem.title = "Профиль"
        profileNC.tabBarItem.image = UIImage(systemName: "person.crop.circle")

    }

    @objc private func didPressHelpButton() {
        selectedIndex = 2
        helpButton.backgroundColor = .white
        heartImageView.tintColor = UIViewConstants.leaf
    }
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let selectedIndex = self.tabBar.items?.firstIndex(of: item)
        if selectedIndex == 2 {
            helpButton.backgroundColor = .white
            heartImageView.tintColor = UIViewConstants.leaf
        } else {
            helpButton.backgroundColor = UIViewConstants.leaf
            heartImageView.tintColor = .white
        }
    }
}
