//
//  PresenterInterface.swift
//  iOSCodeTest
//
//  Created by Joonghoo Im on 2021/04/14.
//

import Foundation

/**
 Presenter 역할의 필요한 공통 Protocol
 */
protocol PresenterInterface: class {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
}

/**
 화면 간의 데이터 전달시 아래 프로토콜을 통해 전달
 */
protocol DelegatePresenterInterface:class {
    /**
     - Parameter sender: PresenterInterface 타입의 객체, 어떤 VIPER로 부터 넘어오는지 점검 및 객체제어
     - Parameter data: 넘어오는 데이터
     - Parameter actionType: 동작명령타입, enum으로 정의된 타입을 string으로 변환하면 좋을듯??
     */
    func passData(sender:PresenterInterface, data:[String: Any]?)
}

// MARK: Extension - Public Functions
extension PresenterInterface {
    func viewDidLoad() {
        fatalError("Implementation pending...")
    }

    func viewWillAppear(animated: Bool) {
        fatalError("Implementation pending...")
    }

    func viewDidAppear(animated: Bool) {
        fatalError("Implementation pending...")
    }

    func viewWillDisappear(animated: Bool) {
        fatalError("Implementation pending...")
    }

    func viewDidDisappear(animated: Bool) {
        fatalError("Implementation pending...")
    }
}
