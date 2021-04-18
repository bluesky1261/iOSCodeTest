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
        if let imageUrl = photoItem?.urls.raw {
            if let image = photoModelService.imageCache.image(withIdentifier: imageUrl) {
                self.pictureImageView.image = image
            } else {
                photoModelService.loadPhotoImage(imageUrl: imageUrl, frameSize: UIScreen.main.bounds.size) { (image) in
                    guard let image = image else { return }

                    self.pictureImageView.image = image
                }
            }
        }

        pictureNameLabel.text = photoItem?.user.name

        if let sponsorName = photoItem?.sponsorship?.sponsor.name, let name = photoItem?.user.name {
            if sponsorName == name {
                sponsorNameLabel.text = "Sponsored"
            } else {
                sponsorNameLabel.text = "Sponsored by \(sponsorName)"
            }
        }
    }
}
