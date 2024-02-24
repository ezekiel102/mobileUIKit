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

        appearance.backgroundColor = UIViewConstants.leaf
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont(name: "OfficinaSansExtraBoldC", size: 21)!]

        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.compactAppearance = appearance

        self.navigationBar.tintColor = .white
        UIBarButtonItem.appearance().tintColor = .white
    }

    @objc func exitButtonPressed() {
        exit(0)
    }

}
