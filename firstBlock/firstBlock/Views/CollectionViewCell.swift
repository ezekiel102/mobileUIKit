//
//  CollectionViewCell.swift
//  firstBlock
//
//  Created by Рустем on 23.02.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var helpCategoryName: UILabel!

    @IBOutlet weak var helpCategoryLogo: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        helpCategoryName.font = UIFont(name: "OfficinaSansExtraBoldC", size: 15)!
    }
}
