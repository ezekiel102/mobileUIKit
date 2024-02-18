//
//  TabBarController.swift
//  firstBlock
//
//  Created by Рустем on 18.02.2024.
//

import UIKit

class TapBarController: UITabBarController {

    // MARK: - Delegate properties and functions

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    // MARK: - Private constants

    private enum UIConstants {
        static let helpCategoryButtonSize: CGFloat = 42
        static let heartImageViewHeightSize: CGFloat = 15
        static let heartImageViewWidthSize: CGFloat = 18

    }

    // MARK: - Private properties

    private lazy var helpCategoryButton: UIButton = {
        let helpCategoryButton = UIButton()
        helpCategoryButton.layer.cornerRadius = UIConstants.helpCategoryButtonSize / 2
        helpCategoryButton.backgroundColor = UIViewConstants.helpCategoryButtonColor
        helpCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        return helpCategoryButton
    }()

    private lazy var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(systemName: "heart.fill")
        heartImageView.tintColor = .white
        heartImageView.translatesAutoresizingMaskIntoConstraints = false
        return heartImageView
    }()

    // MARK: - Public properties

    // MARK: - Private methods

    private func initialize() {
        tabBar.addSubview(helpCategoryButton)
        helpCategoryButton.addSubview(heartImageView)

        NSLayoutConstraint.activate([
        helpCategoryButton.heightAnchor.constraint(
            equalToConstant: UIConstants.helpCategoryButtonSize),
        helpCategoryButton.widthAnchor.constraint(
            equalToConstant: UIConstants.helpCategoryButtonSize),
        helpCategoryButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
        helpCategoryButton.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            heartImageView.heightAnchor.constraint(
                equalToConstant: UIConstants.heartImageViewHeightSize),
            heartImageView.widthAnchor.constraint(
                equalToConstant: UIConstants.heartImageViewWidthSize),
            heartImageView.centerXAnchor.constraint(equalTo: helpCategoryButton.centerXAnchor),
            heartImageView.centerYAnchor.constraint(equalTo: helpCategoryButton.centerYAnchor)
        ])

        let newsVC = UIViewController()
        newsVC.view.backgroundColor = .yellow
        newsVC.tabBarItem.title = "Новости"
        newsVC.tabBarItem.image = UIImage(systemName: "list.bullet")?
            .withTintColor(UIViewConstants.warmGrey)

        let searchVC = UIViewController()
        searchVC.view.backgroundColor = .blue
        searchVC.tabBarItem.title = "Поиск"
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")?
            .withTintColor(.red)
        searchVC.tabBarItem.badgeColor = .red

        let helpCategoryVC = UIViewController()
        helpCategoryVC.view.backgroundColor = .brown
        helpCategoryVC.tabBarItem.title = "Помочь"

        let historyVC = UIViewController()
        historyVC.view.backgroundColor = .red
        historyVC.tabBarItem.title = "История"
        historyVC.tabBarItem.image = UIImage(systemName: "clock.arrow.circlepath")?
            .withTintColor(UIViewConstants.warmGrey)

        let profileVC = UIViewController()
        profileVC.view.backgroundColor = .green
        profileVC.tabBarItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")?
            .withTintColor(UIViewConstants.warmGrey)

        viewControllers = [newsVC, searchVC, helpCategoryVC, historyVC, profileVC]

    }

    // MARK: - Public methods


}
