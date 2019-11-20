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

// 뷰 모델 추가되는 것
// 1. 의존성을 주입하는 생성자.
// 2. 바인딩에 사용되는 프로퍼티와 메소드

class MemoListViewModel: CommonViewModel {
    // 메모 목록
    var memoList: Observable<[MemoModel]> {
        return storage.memoList()
    }
}
