//
//  SearchViewController.swift
//  firstBlock
//
//  Created by Рустем on 18.02.2024.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setupNavigationBar()
        self.navigationItem.title = "Поиск"
        addExitButton()
        view.backgroundColor = .orange
    }

}
