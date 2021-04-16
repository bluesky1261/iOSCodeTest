//
//  MainPictureCell.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/14.
//

import UIKit

class MainPictureCell: UICollectionViewCell {

    private let photoModelService = PhotoModelService.shared
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var pictureNameLabel: UILabel!
    @IBOutlet weak var sponsorNameLabel: UILabel!

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
        pictureImageView.image = nil
        pictureNameLabel.text = ""
        sponsorNameLabel.text = ""
    }

    func updateCell() {
        if let imageUrl = photoItem?.urls.regular {
            photoModelService.loadPhotoImage(imageUrl: imageUrl) { (image) in
                guard let image = image else { return }

                self.pictureImageView.image = image
            }
        }

        pictureNameLabel.text = photoItem?.user.username
        sponsorNameLabel.text = photoItem?.sponsorship?.sponsor.username
    }
}
