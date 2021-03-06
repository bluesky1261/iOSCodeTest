//
//  SearchWireframe.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/17.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class SearchWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: "Search", bundle: nil)

    // MARK: - Module setup -

    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: SearchViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = SearchInteractor()
        let presenter = SearchPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension SearchWireframe: SearchWireframeInterface {
    func navigate(to option: SearchNavigationOption) {
        switch option {
        case .detail(let delegate, let section, let index, let photoModels):
            showDetail(delegate: delegate, section: section, index: index, photoModels: photoModels)
        }
    }

    func showDetail(delegate: DelegatePresenterInterface, section: Int, index: Int, photoModels: [Int:[PhotoModel]]) {
        navigationController?.pushWireframe(DetailWireframe(delegate: delegate, section: section, index: index, photoModels: photoModels))
    }
}
