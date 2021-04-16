//
//  DetailViewController.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/15.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet weak var detailCollectionView: UICollectionView!

    // MARK: - Public properties -

    var presenter: DetailPresenterInterface!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        detailCollectionView.reloadData()
        detailCollectionView.layoutIfNeeded()
        detailCollectionView.scrollToItem(at: IndexPath(item: presenter.getCurrentPhotoIndex(), section: presenter.getCurrentPhotoSection()), at: .centeredHorizontally, animated: false)
    }
}

// MARK: - Extensions -

extension DetailViewController: DetailViewInterface {
    func setupUI() {
        navigationItem.hidesBackButton = true

        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeButtonTouched(sender:)))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton

        let detailCollectionViewLayout = UICollectionViewFlowLayout()

        detailCollectionViewLayout.scrollDirection = .horizontal
        detailCollectionViewLayout.itemSize = detailCollectionView.frame.size
        detailCollectionViewLayout.sectionInset = .zero
        detailCollectionViewLayout.minimumLineSpacing = .zero
        detailCollectionViewLayout.minimumInteritemSpacing = .zero

        detailCollectionView.setCollectionViewLayout(detailCollectionViewLayout, animated: false)
        detailCollectionView.isPagingEnabled = true
        detailCollectionView.alwaysBounceHorizontal = true

        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self

        let bundle = Bundle(for: DetailPictureCell.self)
        let nib = UINib(nibName: String(describing: DetailPictureCell.self), bundle: bundle)

        detailCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: DetailPictureCell.self))
    }
}

private extension DetailViewController {
    @objc func closeButtonTouched(sender: UIBarButtonItem) {
        presenter.passCurrentPhotoInfo()
        navigationController?.popViewController(animated: true)
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let visibleCell = detailCollectionView.visibleCells.first,
              let indexPath = detailCollectionView.indexPath(for: visibleCell) else { return }

        presenter.updateCurrentPosition(section: indexPath.section, index: indexPath.item)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.getSectionCount()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getPhotoSectionList(for: section).count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailPictureCell.self), for: indexPath) as! DetailPictureCell

        cell.photoItem = presenter.getPhotoSectionList(for: indexPath.section)[indexPath.item]

        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return detailCollectionView.frame.size
    }
}
