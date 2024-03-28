//
//  HeaderCollectionReusableView.swift
//  firstBlock
//
//  Created by Рустем on 18.03.2024.
//

import UIKit
import SnapKit

class HeaderCollectionReusableView: UICollectionReusableView {

    static let identifier = "HeaderCollectionReusableView"

    func configure() {
        loadHeaderView()
    }

    private var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = "Выберите категорию помощи"
        headerLabel.font = .textStyle2
        headerLabel.textColor = .charcoalGrey
        return headerLabel
    }()

}

private extension HeaderCollectionReusableView {

    func loadHeaderView() {
        backgroundColor = .white
        addSubview(headerLabel)

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(20)
            make.centerX.equalToSuperview()
        }
    }

}
