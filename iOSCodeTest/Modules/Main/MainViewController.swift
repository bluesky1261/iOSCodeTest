//
//  MainViewController.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/14.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var pictureCollectionView: UICollectionView!

    // MARK: - Public properties -

    var presenter: MainPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        setupUI()
    }
}

// MARK: - Extensions -

extension MainViewController: MainViewInterface {
    func setupUI() {
        let pictureCollectionViewLayout = UICollectionViewFlowLayout()

        pictureCollectionViewLayout.headerReferenceSize = .zero
        pictureCollectionViewLayout.footerReferenceSize = .zero
        pictureCollectionViewLayout.scrollDirection = .vertical
        pictureCollectionViewLayout.sectionInset = .zero
        pictureCollectionViewLayout.minimumLineSpacing = .zero

        pictureCollectionView.setCollectionViewLayout(pictureCollectionViewLayout, animated: false)
        pictureCollectionView.decelerationRate = .fast

        pictureCollectionView.dataSource = self
        pictureCollectionView.delegate = self

        let pictureBundle = Bundle(for: MainPictureCell.self)
        let pictureNib = UINib(nibName: String(describing: MainPictureCell.self), bundle: pictureBundle)

        pictureCollectionView.register(pictureNib, forCellWithReuseIdentifier: String(describing: MainPictureCell.self))

        let categoryCollectionViewLayout = UICollectionViewFlowLayout()

        categoryCollectionViewLayout.headerReferenceSize = .zero
        categoryCollectionViewLayout.footerReferenceSize = .zero
        categoryCollectionViewLayout.scrollDirection = .horizontal
        categoryCollectionViewLayout.sectionInset = .zero

        categoryCollectionView.setCollectionViewLayout(categoryCollectionViewLayout, animated: false)
        categoryCollectionView.showsHorizontalScrollIndicator = false

        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self

        let categoryBundle = Bundle(for: MainCategoryCell.self)
        let categoryNib = UINib(nibName: String(describing: MainCategoryCell.self), bundle: categoryBundle)

        categoryCollectionView.register(categoryNib, forCellWithReuseIdentifier: String(describing: MainCategoryCell.self))
    }

    func updateTopicList() {
        DispatchQueue.main.async {
            self.categoryCollectionView.reloadData()
            self.categoryCollectionView.layoutIfNeeded()
        }
    }

    func updatePhotoList() {
        self.pictureCollectionView.reloadData()
        self.pictureCollectionView.layoutIfNeeded()
    }

    func updatePhotoList(section: Int) {
        self.pictureCollectionView.insertSections(IndexSet(integer: section))
        self.pictureCollectionView.layoutIfNeeded()
    }

    func updatePhotoListWithPosition(currentSection: Int, currentIndex: Int) {
        updatePhotoList()
        self.pictureCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: currentSection), at: .centeredVertically, animated: false)
    }
}

// MARK: - Extensions: UICollectionViewDelegate -
extension MainViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        if position > pictureCollectionView.contentSize.height - (scrollView.frame.size.height * 2) {
            presenter.requestMorePhoto()
        }
    }
}

// MARK: - Extensions: UICollectionViewDataSource -
extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == categoryCollectionView {
            return presenter.getTopicSectionCount()
        } else if collectionView == pictureCollectionView {
            return presenter.getPhotoSectionCount()
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return presenter.getTopicSectionList(for: section).count
        } else if collectionView == pictureCollectionView {
            return presenter.getPhotoSectionList(for: section).count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainCategoryCell.self), for: indexPath) as! MainCategoryCell

            var topicItem = presenter.getTopicSectionList(for: indexPath.section)[indexPath.item]

            if indexPath.item == presenter.getCurrentTopicIndex() {
                topicItem.topicSelected = true
            } else {
                topicItem.topicSelected = false
            }

            cell.topicItem = topicItem

            return cell
        } else if collectionView == pictureCollectionView {
            let cell = pictureCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MainPictureCell.self), for: indexPath) as! MainPictureCell

            cell.photoItem = presenter.getPhotoSectionList(for: indexPath.section)[indexPath.item]

            return cell
        } else {
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            presenter.updateCurrentTopicIndex(index: indexPath.item)
        } else if collectionView == pictureCollectionView {
            collectionView.deselectItem(at: indexPath, animated: false)
            presenter.moveToDetail(section: indexPath.section, index: indexPath.item)
        }
    }

}

// MARK: - Extensions: UICollectionViewDelegateFlowLayout -
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pictureCollectionView {
            let photoItem = presenter.getPhotoSectionList(for: indexPath.section)[indexPath.item]

            let collectionViewWidth = collectionView.frame.width
            let photoWidth = CGFloat(photoItem.width)
            let photoHeight = CGFloat(photoItem.height)

            let calculatedHeight = ceil(photoHeight * collectionViewWidth / photoWidth)

            return CGSize(width: collectionViewWidth, height: calculatedHeight)
        } else if collectionView == categoryCollectionView {
            let topicItem = presenter.getTopicSectionList(for: indexPath.section)[indexPath.item]
            let titleString = NSString(string: topicItem.title)
            
            return CGSize(width: titleString.size(withAttributes: nil).width + 10, height: categoryCollectionView.bounds.height)
        } else {
            return .zero
        }
    }
}
