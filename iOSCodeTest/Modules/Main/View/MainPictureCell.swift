//
//  MainPictureCell.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/14.
//

import UIKit
import Alamofire

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

    private var currentRequest: DataRequest?

    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
        initUI()
    }

    override func prepareForReuse() {
        initUI()
    }

    func initUI() {
        // Cell 초기화시 진행중인 Network Request가 존재한다면 종료 처리
        if let currentRequest = currentRequest {
            currentRequest.cancel()
        }

        pictureImageView.image = nil
        pictureNameLabel.text = ""
        sponsorNameLabel.text = ""
    }

    func updateCell() {
        if let imageUrl = photoItem?.urls.raw {
            if let image = photoModelService.imageCache.image(withIdentifier: imageUrl) {
                self.pictureImageView.image = image
            } else {
                currentRequest = photoModelService.loadPhotoImage(imageUrl: imageUrl, frameSize: UIScreen.main.bounds.size) { (image) in
                    guard let image = image else { return }

                    self.pictureImageView.image = image.resizedImage(with: CGSize(width: image.size.width, height: image.size.height))
                    self.currentRequest = nil
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
