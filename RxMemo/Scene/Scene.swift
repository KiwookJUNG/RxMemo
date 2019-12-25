//
//  Scene.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import UIKit


// Scene과 연결된 뷰 모델을 연관값으로 저장하는 열거형
enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

// MARK: Scene을 생성하고(스토리보드)
// 연관값에 저장된 뷰모델을 바인딩하는 메소드
extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        // 메모 목록 신 생성, 뷰 모델 바인딩 후 리턴
        switch self {
            
            
        case .list(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNavigation") as? UINavigationController else {
                fatalError()
            }
            
            guard var listVC = nav.viewControllers.first as? MemoListViewController else {
                fatalError()
            }
            
            listVC.bind(viewModel: viewModel)
            return nav
            
            
            
        case .detail(let viewModel):
            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? MemoDetailViewController else {
                fatalError()
            }
            
            detailVC.bind(viewModel: viewModel)
            
            return detailVC
            
            
        case .compose(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNavigation") as? UINavigationController else {
                fatalError()
            }
            
            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else {
                fatalError()
            }
            
            composeVC.bind(viewModel: viewModel)
            return nav
        }
    }
}
