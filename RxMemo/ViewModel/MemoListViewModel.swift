//
//  MemoListViewModel.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Action

// 뷰 모델 추가되는 것
// 1. 의존성을 주입하는 생성자.
// 2. 바인딩에 사용되는 프로퍼티와 메소드

class MemoListViewModel: CommonViewModel {
    // 메모 목록
    var memoList: Observable<[MemoModel]> {
        return storage.memoList()
    }
    
    func performUpdate(memo: MemoModel) -> Action<String, Void> {
        return Action { input in
            return self.storage.updateMemo(memo: memo, content: input).map { _ in }
        }
    }
    
    func performCancel(memo: MemoModel) -> CocoaAction {
        return Action {
            return self.storage.deleteMemo(memo: memo).map { _ in }
        }
    }
    
    // 뷰 모델이 메모 목록 화면에서 메모 쓰기 화면으로 전환하는 코드를 처리해야한다.
    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            return self.storage.createMemo(content: "")
                .flatMap { memo -> Observable<Void> in
                    let composeViewModel = MemoComposeViewModel(title: "새 메모",  sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))
                    
                    let composeScene = Scene.compose(composeViewModel)
                    
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
            }
        }
    }
    
    lazy var detailAction: Action<MemoModel, Void> = {
        return Action { memo in
            let detailViewModel = MemoDetailViewModel(memo: memo, title: "메모 보기", sceneCoordinator: self.sceneCoordinator, storage: self.storage)
            
            let detailScene = Scene.detail(detailViewModel)
            
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map { _ in }
        }
    }()
    
    lazy var deleteAction: Action<MemoModel, Swift.Never> = {
        return Action { memo in
            return self.storage.deleteMemo(memo: memo).ignoreElements()
        }
    }()
 
}
