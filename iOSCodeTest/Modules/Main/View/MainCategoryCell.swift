//
//  MainCategoryCell.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/15.
//

import UIKit

class MainCategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!

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
        selectedView.backgroundColor = .white
    }

    func updateCell() {
        if let topicSelected = topicItem?.topicSelected, topicSelected {
            selectedView.backgroundColor = .black
        } else {
            selectedView.backgroundColor = .white
        }
        categoryLabel.text = topicItem?.title
    }
}
