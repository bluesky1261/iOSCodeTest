//
//  SearchHistoryModel.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/16.
//

import Foundation

struct SearchHistoryModel: Codable {
    let searchText: String
    let savedDate: Date
}
