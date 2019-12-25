//
//  SceneCoordinator.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension UIViewController {
    var sceneViewController: UIViewController {
        return self.children.first ?? self
    }
}

class SceneCoordinator: SceneCoordinatorType {
    
    private let bag = DisposeBag()
    
    // 신 코디네이터는 화면전환을 담당하기 때문에 윈도우 인스턴스와 현재화면에 표시되는 인스턴스를 가지고 있어야함
    private var window: UIWindow
    private var currentVC: UIViewController
    
    // window와 currentVC를 초기화 하는 필수 생성자
    required init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        // 전환 결과를 방출할 서브젝트
        let subject = PublishSubject<Void>()
        
        // 신을 생성
        let target = scene.instantiate()
        
        switch style {
        // root인 경우에는 그냥 rootVC를 바꿔준다.
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()
            
            
        // 네비게이션에 임베드 돼있지 않다면 에러
        case .push:
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.navigationControllerMissing)
                break
            }
            
            nav.rx.willShow
                .subscribe(onNext: { [unowned self] evt in
                    self.currentVC = evt.viewController.sceneViewController
                })
                .disposed(by: bag)
            
            // 네이게이션이 있다면 푸쉬 후 컴플리티드
            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController
    
            subject.onCompleted()
            
            
            
        // 신을 프레젠트
        case .modal:
            currentVC.present(target, animated: animated) {
                subject.onCompleted()
            }
            
            currentVC = target.sceneViewController
        }
        
        // subject.ignoreElements()를 하면 서브젝트의 반환형이 Completable로 방출된다.
        return subject.ignoreElements()
    }
    
    
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        // subject를 생성하여 subject.ignoreElements()로 Completable을 반환하는게 아니라
        // Completable을 생성하여 클로저로 Completable을 반환한다.
        return Completable.create { [unowned self] completable in
            
            // modal 방식으로 전환된 화면은 dismiss 해준다
            if let presentingVC = self.currentVC.presentingViewController {
                self.currentVC.dismiss(animated: animated) {
                    self.currentVC = presentingVC.sceneViewController
                    completable(.completed)
                }
            } else if let nav = self.currentVC.navigationController {
                // 네이게이션 방식으로 전환된 화면은 pop 해주고 pop할 수 없으면 에러
                guard nav.popViewController(animated: animated) != nil else {
                    completable(.error(TransitionError.cannotPop))
                    return Disposables.create()
                }
                        
                self.currentVC = nav.viewControllers.last!
                completable(.completed)
            } else {
                // 그 외의 에러는 unknown 에러 처리한다.
                completable(.error(TransitionError.unknown))
            }
            
            return Disposables.create()
        }
            
    }
}
    
    
    

