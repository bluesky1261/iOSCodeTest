//
//  DetailPictureCell.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/15.
//

import UIKit

class DetailPictureCell: UICollectionViewCell {

    @IBOutlet weak var detailPictureImageView: UIImageView!

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

}
