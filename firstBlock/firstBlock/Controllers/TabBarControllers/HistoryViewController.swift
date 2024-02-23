//
//  HistoryViewController.swift
//  firstBlock
//
//  Created by Рустем on 18.02.2024.
//

import UIKit

class HistoryViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setupNavigationBar()
        self.navigationItem.title = "История"
        let exitButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(navigationController?.exitButtonPressed))
        self.navigationItem.leftBarButtonItem = exitButton
    }

}
