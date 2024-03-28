//
//  TabBarController.swift
//  firstBlock
//
//  Created by Рустем on 18.02.2024.
//

import UIKit
import SnapKit

class TabBarController: UITabBarController {

    var tabBarViewModel: TabBarViewModel! {
        didSet {
            helpVC.helpViewModel = tabBarViewModel.helpViewModel
        }
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCustomMainTabView()
        loadViewControllers()
    }

    // MARK: - Private constants

    private enum UIConstants {
        static let helpButtonSize: CGFloat = 42
        static let circleRadius: CGFloat = 27
    }

    private var tabBarCenter: CGFloat { self.tabBar.bounds.width / 2 }

    // MARK: - Private properties

    private var newsVC = NewsViewController()
    private var searchVC = SearchViewController()
    private var helpVC = HelpCollectionViewController()
    private var historyVC = HistoryViewController()
    private var profileVC = ProfileViewController()

    private var helpButton: UIButton = {
        let helpButton = UIButton()
        helpButton.layer.cornerRadius = UIConstants.helpButtonSize / 2
        helpButton.backgroundColor = .leaf
        helpButton.layer.shadowColor = UIColor.leaf.cgColor
        helpButton.layer.shadowOpacity = 0.7
        helpButton.layer.shadowOffset = .zero
        helpButton.layer.shadowRadius = 2
        return helpButton
    }()

    private var heartImageView: UIImageView = {
        let heartImageView = UIImageView()
        heartImageView.image = UIImage(systemName: "heart.fill")
        heartImageView.tintColor = .white
        return heartImageView
    }()

    private lazy var circleLayer: CAShapeLayer = {
        let circleLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: tabBarCenter, y: 12),
                    radius: UIConstants.circleRadius,
                    startAngle: .pi,
                    endAngle: 0 * 180 / .pi,
                    clockwise: true)
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.shadowPath = path.cgPath
        circleLayer.shadowColor = UIColor.whiteTwo.cgColor
        circleLayer.shadowOpacity = 0.2
        circleLayer.shadowRadius = 2
        return circleLayer
    }()

}

private extension TabBarController {

    func loadCustomMainTabView() {
        tabBar.layer.addSublayer(circleLayer)
        tabBar.layer.backgroundColor = UIColor.white.cgColor
        tabBar.layer.shadowColor = UIColor.black20.cgColor
        tabBar.layer.shadowOpacity = 0.2
        tabBar.layer.shadowRadius = 2

        tabBar.addSubview(helpButton)
        helpButton.addSubview(heartImageView)
        helpButton.addTarget(self,
                             action: #selector(didPressHelpButton),
                             for: .touchUpInside)

        helpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tabBar.snp.top).offset(-10)
            make.width.height.equalTo(UIConstants.helpButtonSize)
        }

        heartImageView.snp.makeConstraints { make in
            make.center.equalTo(helpButton.snp.center)
        }
    }

    func loadViewControllers() {
        let newsNC = UINavigationController(rootViewController: newsVC)
        newsNC.tabBarItem.title = "Новости"
        newsNC.tabBarItem.image = UIImage(systemName: "list.bullet")

        let searchNC = UINavigationController(rootViewController: searchVC)
        searchNC.tabBarItem.title = "Поиск"
        searchNC.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        let helpNC = UINavigationController(rootViewController: helpVC)
        helpNC.tabBarItem.title = "Помочь"

        let historyNC = UINavigationController(rootViewController: historyVC)
        historyNC.tabBarItem.title = "История"
        historyNC.tabBarItem.image = UIImage(systemName: "clock.arrow.circlepath")

        let profileNC = UINavigationController(rootViewController: profileVC)
        profileNC.tabBarItem.title = "Профиль"
        profileNC.tabBarItem.image = UIImage(systemName: "person.crop.circle")

        viewControllers = [newsNC, searchNC, helpNC, historyNC, profileNC]

        selectedIndex = 2

    }

    @objc private func didPressHelpButton() {
        selectedIndex = 2
        helpButton.backgroundColor = .leaf
        heartImageView.tintColor = .white
    }

}

extension UITabBar {

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let pointIsInside = super.point(inside: point, with: event)
        if pointIsInside == false {
            for subview in subviews {
                let pointInSubview = subview.convert(point, from: self)
                if subview.point(inside: pointInSubview, with: event) {
                    return true
                }
            }
        }
        return pointIsInside
    }

}

extension TabBarController: UITabBarControllerDelegate {

    override func tabBar(_ tabBar: UITabBar,
                         didSelect item: UITabBarItem) {
        let selectedIndex = self.tabBar.items?.firstIndex(of: item)
        if selectedIndex == 2 {
            helpButton.backgroundColor = .leaf
            heartImageView.tintColor = .white
        } else {
            helpButton.backgroundColor = .white
            heartImageView.tintColor = .leaf
        }
    }

}
