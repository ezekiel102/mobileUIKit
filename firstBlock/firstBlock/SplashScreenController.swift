//
//  ViewController.swift
//  firstBlock
//
//  Created by Рустем on 05.02.2024.
//

import UIKit

class SplashScreenController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(segueToSignIn), userInfo: nil, repeats: false)
    }

    @objc func segueToSignIn() {
        self.performSegue(withIdentifier: "toMainView", sender: self)
    }
}
