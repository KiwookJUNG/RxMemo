//
//  SceneCordinatorType.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import Foundation
import RxSwift

// SceneCoordinator가 공통적으로 구현해야하는 프로퍼티 및 메소드를 선언하는 프로토콜

protocol SceneCoordinatorType {
    
    // 새로운 신을 표시한다.
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    // 현재 신을 닫고 이전 신으로 돌아간다.
    @discardableResult
    func close(animated: Bool) -> Completable
    
}
