//
//  UIViewController+Extension.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/14.
//

import UIKit

// MARK: - Extension: UIViewController -
extension UIViewController {
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (()->())? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}
