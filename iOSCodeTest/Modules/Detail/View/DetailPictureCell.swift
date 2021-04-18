//
//  DetailPictureCell.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/15.
//

import UIKit

class DetailPictureCell: UICollectionViewCell {
    private let photoModelService = PhotoModelService.shared

    @IBOutlet weak var detailPictureImageView: UIImageView!

    var photoItem: PhotoModel? {
        didSet {
            updateCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        initUI()
    }

    override func prepareForReuse() {
        initUI()
    }

    func initUI() {
        detailPictureImageView.image = nil
    }

    func updateCell() {
        if let imageUrl = photoItem?.urls.raw {
            if let image = photoModelService.imageCache.image(withIdentifier: imageUrl) {
                self.detailPictureImageView.image = image
            } else {
                photoModelService.loadPhotoImage(imageUrl: imageUrl, frameSize: detailPictureImageView.bounds.size) { (image) in
                    guard let image = image else { return }

                    self.detailPictureImageView.image = image
                }
            }
        }
    }
}
