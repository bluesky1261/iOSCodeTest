//
//  MainPictureCell.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/14.
//

import UIKit

class MainPictureCell: UICollectionViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var pictureNameLabel: UILabel!
    @IBOutlet weak var sponsorNameLabel: UILabel!

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
}
