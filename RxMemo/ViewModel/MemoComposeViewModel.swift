//
//  MemoComposeViewModel.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoComposeViewModel: CommonViewModel {
    // 메모를 저장하는 속성
    private let content: String?
    
    // 뷰에 바인딩할 수 있는 드라이버 추가.
    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }
    
    // 저장과 취소 두 가지 액션을 구현함
    
    // 액션을 저장하는 속성
    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    // 뷰 모델에서 취소코드와 저장코드를 직접 구현하지 않고 파라미터로 받는다.
    // 이렇게 하면 처리방식이 하나로 고정되지않고 이전 화면에서 처리방식을 동적으로 결정할 수 있다.
    init(title: String, content: String? = nil, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType, saveAction: Action<String, Void>?, cancelAction: CocoaAction? = nil) {
        
        self.content = content
        
        // saveAction으로 전달된 액션을 액션으로 한 번더 맵핑하여 실제로 전달됐으면 실행하고 화면닫고
        // 아니면 화면만 닫고 끝낸다.
        self.saveAction = Action<String, Void> { input in
            if let action = saveAction {
                action.execute(input)
            }
            
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute(())
            }
            
            return sceneCoordinator.close(animated: true).asObservable().map { _ in }
        }
        
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: storage)
    }
}
