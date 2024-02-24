//
//  NewsViewController.swift
//  firstBlock
//
//  Created by Рустем on 18.02.2024.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setupNavigationBar()
        self.navigationItem.title = "Новости"
        let exitButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(navigationController?.exitButtonPressed))
        self.navigationItem.leftBarButtonItem = exitButton
    }
}
