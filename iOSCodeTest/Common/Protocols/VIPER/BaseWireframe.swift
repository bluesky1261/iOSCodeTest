//
//  BaseWireframe.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/14.
//

import UIKit

/**
 Wireframe 역할의 필요한 공통 Protocol
 */
protocol WireframeInterface: class {
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool)
    func dismiss(animated: Bool)
}

class BaseWireframe {
    private unowned var _viewController: UIViewController

    // To retain view controller reference upon first access
    private var _temporaryStoredViewController: UIViewController?

    init(viewController: UIViewController) {
        _temporaryStoredViewController = viewController
        _viewController = viewController
    }
}

// MARK: Extension - Public Variables
extension BaseWireframe {
    var viewController: UIViewController {
        defer { _temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
}

// MARK: Extension - Public Functions
extension BaseWireframe {
    func pushWireframe(_ wireframe: BaseWireframe, animated: Bool = true) {
        let viewController = wireframe.viewController
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }
}
