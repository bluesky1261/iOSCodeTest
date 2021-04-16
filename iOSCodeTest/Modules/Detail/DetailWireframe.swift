//
//  DetailWireframe.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/15.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class DetailWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: "Detail", bundle: nil)

    // MARK: - Module setup -

    init(delegate: DelegatePresenterInterface) {
        let moduleViewController = storyboard.instantiateViewController(ofType: DetailViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = DetailInteractor()
        let presenter = DetailPresenter(delegate: delegate, view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension DetailWireframe: DetailWireframeInterface {
}
