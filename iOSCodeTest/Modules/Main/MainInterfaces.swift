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
    func navigate(to option: MainNavigationOption)
}

protocol MainViewInterface: ViewInterface {
    func updateTopicList()
    func updatePhotoList()
    func updatePhotoList(section: Int)
    func updatePhotoListWithPosition(currentSection: Int, currentIndex: Int)
}

protocol MainPresenterInterface: PresenterInterface {
    func getTopicSection() -> Int
    func getTopicSectionList(for section: Int) -> [TopicModel]
    func getTopicSectionCount() -> Int
    func getPhotoSection() -> Int
    func getPhotoSectionList(for section: Int) -> [PhotoModel]
    func getPhotoSectionCount() -> Int
    
    func moveToDetail(section: Int, index: Int)
    func requestMorePhoto()
}

protocol MainInteractorInterface: InteractorInterface {
    func listTopics(page: Int, completion: @escaping TopicListCompletionHandler)
    func listPhotos(page: Int, completion: @escaping PhotoListCompletionHandler)
}
