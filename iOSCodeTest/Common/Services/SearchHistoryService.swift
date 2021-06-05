//
//  SearchHistoryService.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/16.
//

import Foundation

class SearchHistoryService {
    static let shared = SearchHistoryService()

    private init() { }
}

extension SearchHistoryService {
    /// 검색어를 로컬 스토리지의 검색어 히스토리 영역에 저장하는 함수.
    func saveSearchHistory(keyword: String) {
        let newSearchModel = SearchHistoryModel(searchText: keyword, savedDate: Date())
        let historyList = loadSearchHistory()

        var filteredList = historyList.filter { $0.searchText != keyword }

        if filteredList.count > Constant.MAX_HISTORY_SIZE {
            filteredList.removeLast()
        }
        
        filteredList.insert(newSearchModel, at: 0)

        let repository = UserDefaults.standard
        let data = filteredList.jsonData

        repository.setValue(data, forKey: Constant.SEARCH_HISTORY_REPO_KEY)
    }

    /// 로컬 스토리지에서 검색어 히스토리를 조회하는 함수.
    func loadSearchHistory() -> [SearchHistoryModel] {
        let repository = UserDefaults.standard
        if let data = repository.object(forKey: Constant.SEARCH_HISTORY_REPO_KEY) as? Data {
            do {
                let repositoryData = try [SearchHistoryModel].decode(data: data)
                return repositoryData.sorted { $0.savedDate > $1.savedDate }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return [SearchHistoryModel]()
    }

    /// 검색어 히스토리를 초기화 하는 함수.
    func clearSearchHistory() {
        let repository = UserDefaults.standard
        repository.setValue([SearchHistoryModel]().jsonData, forKey: Constant.SEARCH_HISTORY_REPO_KEY)
    }
}
