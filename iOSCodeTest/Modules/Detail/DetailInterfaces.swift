//
//  DetailInterfaces.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/15.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol DetailWireframeInterface: WireframeInterface {
}

protocol DetailViewInterface: ViewInterface {
    /// 특정 섹션의 사진 목록을 갱신해주는 함수
    func updatePhotoList(section: Int)
}

protocol DetailPresenterInterface: PresenterInterface {
    /// 현재 화면에 Focus된 사진의 섹션정보를 리턴하는 함수
    func getCurrentPhotoSection() -> Int
    /// 현재 화면에 Focus된 사진의 Index 정보를 리턴하는 함수
    func getCurrentPhotoIndex() -> Int
    /// 특정 섹션에 해당하는 사진 리스트를 가져오는 함수
    func getPhotoSectionList(for section: Int) -> [PhotoModel]
    /// 섹션 갯수를 리턴하는 함수
    func getSectionCount() -> Int
    /// 추가로 네트워크를 통한 사진 조회를 요청하는 함수
    func requestMorePhoto()
    /// 현재 화면에 Focus된 사진의 섹션과 Index 정보를 갱신하는 함수
    func updateCurrentPosition(section: Int, index: Int)
    /// 현재 화면에 Focus된 사진의 정보(섹션, Index, 사진 정보)를 다른 View로 전달하기 위한 함수
    func passCurrentPhotoInfo()
}

protocol DetailInteractorInterface: InteractorInterface {
    func listPhotos(page: Int, completion: @escaping PhotoListCompletionHandler)
}
