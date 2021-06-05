//
//  UIStoryboard+Extension.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/14.
//

import UIKit

// MARK: - Extension: UIStoryboard -
extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(ofType _: T.Type, withIdentifier identifier: String? = nil) -> T {
        let identifier = identifier ?? String(describing: T.self)
        return instantiateViewController(withIdentifier: identifier) as! T
    }
}
