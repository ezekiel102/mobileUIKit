//
//  MainViewController.swift
//  firstBlock
//
//  Created by Рустем on 17.02.2024.
//

import UIKit
import SnapKit

class HelpCollectionViewController: UIViewController {

    var helpViewModel = HelpViewModel()
    private var categories: [HelpCategory]!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setupNavigationBar()
        self.navigationItem.title = "Помочь"
        addExitButton()

        loadQueue()
    }

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

    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        return activityIndicatorView
    }()

}

private extension HelpCollectionViewController {

    func loadQueue() {
        helpViewModel.helpViewModelDelegate = self
        helpViewModel.fetchCategories()
    }

    func loadActivityIndicator() {
        view.backgroundColor = .white
        view.addSubview(activityIndicatorView)

        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(357)
        }

        activityIndicatorView.startAnimating()
    }

    func loadCustomCollectionView() {
        view.backgroundColor = .white
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
        categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HelpCategoryCollectionViewCell.identifier,
            for: indexPath) as? HelpCategoryCollectionViewCell else {
            fatalError("Failed to dequeue HelpCategoryCollectionViewCell in HelpC")
        }
        cell.configure(name: (categories![indexPath.row].name),
                       image: categories![indexPath.row].imageName)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = EventsTableViewController()
        nextVC.eventsViewModel = EventsViewModel(category: categories![indexPath.row])
        nextVC.categories = categories
        navigationController?.pushViewController(nextVC, animated: true)
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

extension HelpCollectionViewController: HelpViewModelDelegate {
    func didStartLoadingCategoriesList() {
        loadActivityIndicator()
    }

    func didFinishLoadingCategoriesList(list: [HelpCategory]) {
        categories = list
        loadCustomCollectionView()
    }

}
