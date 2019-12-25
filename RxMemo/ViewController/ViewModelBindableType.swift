//
//  ViewModelBindable.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import UIKit


// 뷰 모델을 뷰 컨트롤러의 속성(프로퍼티)으로 추가하고 뷰모델과 뷰를 바인딩하는데 필요한 프로토콜
protocol ViewModelBindableType {
    
    // 뷰 모델의 타입은 뷰 컨트롤러마다 달라지므로 제네릭으로 선언
    associatedtype ViewModelType
    var viewModel : ViewModelType! { get set }
    
    
    func bindViewModel()
    
}

// 뷰 컨트롤러의 뷰모델 속성(프로퍼티)에 실제 뷰모델을 저장하고
// bindViewModel() 을 자동으로 호출하는 extension
extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        bindViewModel()
    }
}
