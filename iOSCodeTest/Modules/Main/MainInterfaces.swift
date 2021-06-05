//
//  MainInterfaces.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/14.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

enum MainNavigationOption {
    case detail(DelegatePresenterInterface, Int, Int, [Int:[PhotoModel]])
}

protocol MainWireframeInterface: WireframeInterface {
    /// 다른 화면으로 이동하기 위한 함수
    func navigate(to option: MainNavigationOption)
}

protocol MainViewInterface: ViewInterface {
    /// 카테고리 정보를 갱신하기 위한 함수
    func updateTopicList()
    /// 사진 정보를 갱신하기 위한 함수
    func updatePhotoList()
    /// 특정 섹션에 해당하는 사진 정보를 갱신하기 위한 함수
    func updatePhotoList(section: Int)
    /// 사진 정보를 갱신 하면서 현재 화면의 위치를 특정 포지션으로 옮기는 함수
    func updatePhotoListWithPosition(currentSection: Int, currentIndex: Int)
}

protocol MainPresenterInterface: PresenterInterface {
    /// 현재 카테고리의 섹션 번호를 리턴하는 함수
    func getTopicSection() -> Int
    /// 카테고리의 특정 섹션에 해당하는 카테고리 리스트를 리턴하는 함수
    func getTopicSectionList(for section: Int) -> [TopicModel]
    /// 카테고리의 섹션 갯수를 리턴하는 함수
    func getTopicSectionCount() -> Int
    /// 현재 사진 섹션 번호를 리턴하는 함수
    func getPhotoSection() -> Int
    /// 사진의 특정 섹션에 해당하는 사진 리스트를 리턴하는 함수
    func getPhotoSectionList(for section: Int) -> [PhotoModel]
    /// 사진의 섹션에 갯수를 리턴하는 함수
    func getPhotoSectionCount() -> Int
    /// 현재 카테고리의 Index 정보를 리턴하는 함수
    func getCurrentTopicIndex() -> Int
    /// 현재 카테고리의 Index 정보를 갱신하는 함수
    func updateCurrentTopicIndex(index: Int)
    /// 사진 Detail 화면으로 이동하기 위한 함수
    func moveToDetail(section: Int, index: Int)
    /// 추가로 네트워크를 통한 사진 조회를 요청하는 함수
    func requestMorePhoto()
}

protocol MainInteractorInterface: InteractorInterface {
    /// 네트워크를 통해 카테고리 정보를 요청하는 함수
    func listTopics(page: Int, completion: @escaping TopicListCompletionHandler)
    /// 네트워크를 통해 사진 정보를 요청하는 함수
    func listPhotos(page: Int, topicId: String?, completion: @escaping PhotoListCompletionHandler)
}
