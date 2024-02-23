//
//  ProfileViewController.swift
//  firstBlock
//
//  Created by Рустем on 18.02.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setupNavigationBar()
        self.navigationItem.title = "Профиль"
        let exitButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(navigationController?.exitButtonPressed))
        self.navigationItem.leftBarButtonItem = exitButton
    }
}
