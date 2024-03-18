//
//  MainViewController.swift
//  firstBlock
//
//  Created by Рустем on 17.02.2024.
//

import UIKit
import SnapKit

class HelpCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setupNavigationBar()
        self.navigationItem.title = "Помочь"
        addExitButton()
        do {
            self.array = try self.readOperator.readListFromJSON("HelpCategories")
        } catch {
            print("Categories load error: \(error)")
        }
        view.backgroundColor = .white
        loadCustomCollectionView()
    }

    private var readOperator = ReadOperator()
    private var array: [HelpCategory] = []

    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(HelpCategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: HelpCategoryCollectionViewCell.identifier)
        collectionView.register(HeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HeaderCollectionReusableView.identifier)
        collectionView.isScrollEnabled = true
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }()

}

private extension HelpCollectionViewController {

    func loadCustomCollectionView() {
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9))
        }
    }

}

extension HelpCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        array.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HelpCategoryCollectionViewCell.identifier,
            for: indexPath) as? HelpCategoryCollectionViewCell else {
            fatalError("Failed to dequeue HelpCategoryCollectionViewCell in HelpC")
        }
        cell.configure(name: array[indexPath.row].name,
                       image: array[indexPath.row].imageName)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionReusableView.identifier,
            for: indexPath) as? HeaderCollectionReusableView else {
            fatalError("Failed to dequeue HeaderCollectionReusableView in HelpC")
        }
        header.configure()
        return header
    }
}

extension HelpCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.bounds.width - 27) / 2
        return CGSize(width: cellWidth, height: 160)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: view.bounds.width, height: 57)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
}
