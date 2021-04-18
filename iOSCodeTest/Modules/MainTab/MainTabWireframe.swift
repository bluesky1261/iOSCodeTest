//
//  MainTabWireframe.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/17.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

final class MainTabWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: "MainTab", bundle: nil)

    // MARK: - Module setup -

    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: MainTabViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = MainTabInteractor()
        let presenter = MainTabPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension MainTabWireframe: MainTabWireframeInterface {
}