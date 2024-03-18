//
//  HistoryViewController.swift
//  firstBlock
//
//  Created by Рустем on 18.02.2024.
//

import UIKit

class HistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setupNavigationBar()
        self.navigationItem.title = "История"
        addExitButton()
        view.backgroundColor = .yellow
    }

}
