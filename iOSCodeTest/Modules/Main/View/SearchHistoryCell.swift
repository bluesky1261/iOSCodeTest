//
//  SearchHistoryCell.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/16.
//

import UIKit

class SearchHistoryCell: UICollectionViewCell {

    @IBOutlet weak var searchTextLabel: UILabel!

    var searchHistoryItem: SearchHistoryModel? {
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

    }

    func updateCell() {
        searchTextLabel.text = searchHistoryItem?.searchText
    }
}
