//
//  UINavigationController+Extension.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/14.
//

import UIKit

extension UINavigationController {
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.pushViewController(wireframe.viewController, animated: animated)
    }

    func setRootWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([wireframe.viewController], animated: animated)
    }
}
