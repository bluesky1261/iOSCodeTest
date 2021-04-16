//
//  MainCategoryCell.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/15.
//

import UIKit

class MainCategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!

    var topicItem: TopicModel? {
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
        categoryLabel.text = ""
    }

    func updateCell() {
        categoryLabel.text = topicItem?.title
    }
}
