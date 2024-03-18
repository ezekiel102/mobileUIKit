//
//  HelpCategoryCollectionViewCell.swift
//  firstBlock
//
//  Created by Рустем on 17.03.2024.
//

import UIKit
import SnapKit

class HelpCategoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "HelpCategoryCollectionViewCell"

    func configure(name: String, image: String) {
        self.categoryLabel.text = name
        self.categoryImage.image = UIImage(named: image)
        loadCustomCellView()
    }

    private lazy var categoryImage: UIImageView = {
        let categoryImage = UIImageView()
        categoryImage.contentMode = .scaleAspectFit
        return categoryImage
    }()

    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = .textStyle13
        categoryLabel.textColor = .leaf
        return categoryLabel
    }()

}

private extension HelpCategoryCollectionViewCell {

    func loadCustomCellView() {
        contentView.backgroundColor = .lightGrey
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryLabel)

        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }

        categoryImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
