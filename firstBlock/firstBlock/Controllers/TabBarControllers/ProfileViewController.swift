//
//  ProfileViewController.swift
//  firstBlock
//
//  Created by Рустем on 18.02.2024.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setupNavigationBar()
        self.navigationItem.title = "Профиль"
        addExitButton()
        view.backgroundColor = .purple
    }

}
