//
//  CustomNavigationController.swift
//  firstBlock
//
//  Created by Рустем on 19.02.2024.
//

import UIKit

extension UINavigationController {

    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        appearance.backgroundColor = .leaf
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.textStyle]

        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance

        self.navigationBar.tintColor = .white
        self.navigationBar.topItem?.backButtonTitle = ""
        UIBarButtonItem.appearance().tintColor = .white

    }
}

extension UIViewController {

    func addExitButton() {
        let exitButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(exitButtonPressed))
        self.navigationItem.leftBarButtonItem = exitButton
    }

    func addBackButton() {
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }

    func addShareButton() {
        let shareButton = UIBarButtonItem(
            image: UIImage(named: "iconShare"),
            style: .plain,
            target: self,
            action: #selector(shareButtonPressed))
        self.navigationItem.rightBarButtonItem = shareButton
    }

    func addFilterButton(menu: UIMenu) {
        let filterButton = UIBarButtonItem(title: nil,
                                           image: UIImage(named: "filter"),
                                           target: self,
                                           action: nil,
                                           menu: menu)
        navigationItem.rightBarButtonItem = filterButton
    }

    @objc func exitButtonPressed() {
        exit(1)
    }

    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
        navigationController?.tabBarController?.tabBar.isHidden = false
    }

    @objc func shareButtonPressed() {
        print("oops")
    }
}
