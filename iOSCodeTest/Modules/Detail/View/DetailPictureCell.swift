//
//  DetailPictureCell.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/15.
//

import UIKit
import Alamofire

class DetailPictureCell: UICollectionViewCell {
    private let photoModelService = PhotoModelService.shared

    @IBOutlet weak var detailPictureImageView: UIImageView!

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

        detailPictureImageView.image = nil
    }

    func updateCell() {
        if let imageUrl = photoItem?.urls.raw {
            if let image = photoModelService.imageCache.image(withIdentifier: imageUrl) {
                self.detailPictureImageView.image = image
            } else {
                currentRequest = photoModelService.loadPhotoImage(imageUrl: imageUrl, frameSize: detailPictureImageView.bounds.size) { (image) in
                    guard let image = image else { return }

                    self.detailPictureImageView.image = image
                    self.currentRequest = nil
                }
            }
        }
    }
}
