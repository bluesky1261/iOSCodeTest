//
//  SearchHistoryModel.swift
//  iOSCodeTest
//
//  검색어 히스토리 관리를 위한 객체
//  Created by Joonghoo Im on 2021/04/16.
//

import Foundation

struct SearchHistoryModel: Codable {
    let searchText: String
    let savedDate: Date
}
