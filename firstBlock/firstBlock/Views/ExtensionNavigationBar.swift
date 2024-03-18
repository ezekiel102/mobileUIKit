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
        UIBarButtonItem.appearance().tintColor = .white
    }
}

extension UIViewController {

    func addExitButton() {
        let exitButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(self.exitButtonPressed))
        self.navigationItem.leftBarButtonItem = exitButton
    }

    @objc func exitButtonPressed() {
        exit(1)
    }
}
