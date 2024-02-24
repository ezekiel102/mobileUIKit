//
//  MainViewController.swift
//  firstBlock
//
//  Created by Рустем on 17.02.2024.
//

import UIKit

class HelpCollectionViewController: UICollectionViewController {

    @IBOutlet var helpCollectionView: UICollectionView!

    private let images = ["kids", "adults", "grands", "pets", "events"]
    private let namesOfCategoty = ["Дети", "Взрослые", "Пожилые", "Животные", "Мероприятия"]

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNibName = UINib(nibName: "CollectionViewCell", bundle: nil)
        let headerNibName = UINib(nibName: "HeaderCollectionView", bundle: nil)
        self.helpCollectionView.register(cellNibName,
                                         forCellWithReuseIdentifier: "HelpCategoryCell")
        self.helpCollectionView.register(
            headerNibName,
            forSupplementaryViewOfKind: "header",
            withReuseIdentifier: "HeaderCollectionView")
        self.navigationController?.setupNavigationBar()
        self.navigationItem.title = "Помочь"
        let exitButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(navigationController?.exitButtonPressed))
        self.navigationItem.leftBarButtonItem = exitButton
    }

}

extension HelpCollectionViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "HelpCategoryCell",
            for: indexPath) as! CollectionViewCell
        cell.helpCategoryLogo.image = UIImage(named: images[indexPath.item])
        cell.helpCategoryName.text = namesOfCategoty[indexPath.item]

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderCollectionView",
            for: indexPath) as! HeaderCollectionView
        header.headerCollectionViewText.text = "Выберите категорию помощи"
        return header
    }
}
