//
//  MainViewController.swift
//  firstBlock
//
//  Created by Рустем on 17.02.2024.
//

import UIKit

class HelpCategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let exitButton = UIBarButtonItem(image: UIImage(systemName: "exit"), style: .plain, target: self, action: #selector(exitButtonPressed))
        navigationItem.leftBarButtonItem = exitButton
    }

    @objc func exitButtonPressed() {
        exit(0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
