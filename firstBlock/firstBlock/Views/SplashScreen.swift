//
//  ViewController.swift
//  firstBlock
//
//  Created by Рустем on 09.03.2024.
//

import UIKit
import SnapKit

class SplashScreen: UIViewController {

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCustomView()
    }

    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        view.setNeedsUpdateConstraints()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        updateConstaints()
    }

    // MARK: - Private properties

    private var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()

    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()

    private var loadTextView: UILabel = {
        let loadTextView = UILabel()
        loadTextView.text = "Загрузка..."
        loadTextView.font = .textStyle6
        loadTextView.textColor = .charcoalGrey
        return loadTextView
    }()

    private var simbirSoftLogoView: UIImageView = {
        let simbirSoftLogoView = UIImageView()
        simbirSoftLogoView.image = UIImage(named: "simbirSoft")
        simbirSoftLogoView.contentMode = .scaleAspectFit
        return simbirSoftLogoView
    }()

}

// MARK: - Private methods

private extension SplashScreen {

    func loadCustomView() {
        view.backgroundColor = .paleGrey
        view.addSubview(logoImageView)
        view.addSubview(activityIndicatorView)
        view.addSubview(loadTextView)
        view.addSubview(simbirSoftLogoView)

        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(10)
            make.top.equalTo(view.snp.top).offset(UIScreen.main.bounds.height / 667 * 197)
        }

        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(86)
        }

        loadTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(3.5)
            make.top.equalTo(activityIndicatorView.snp.bottom).offset(20)
        }

        simbirSoftLogoView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0,
                                                                               left: 122,
                                                                               bottom: 48.5,
                                                                               right: 137))
        }
    }

    func updateConstaints() {
        if UIDevice.current.orientation.isLandscape {
            logoImageView.snp.updateConstraints { make in
                make.top.equalTo(view.snp.top).offset(UIScreen.main.bounds.height / 375 * 49)
                make.centerX.equalToSuperview().offset(10)
            }
            activityIndicatorView.snp.updateConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(logoImageView.snp.bottom).offset(UIScreen.main.bounds.height / 375 * 43)
            }
        } else {
            logoImageView.snp.updateConstraints { make in
                make.top.equalTo(view.snp.top).offset(UIScreen.main.bounds.height / 667 * 197)
                make.centerX.equalToSuperview().offset(10)
            }
            activityIndicatorView.snp.updateConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(logoImageView.snp.bottom).offset(UIScreen.main.bounds.height / 667 * 86)
            }
        }
    }

}
