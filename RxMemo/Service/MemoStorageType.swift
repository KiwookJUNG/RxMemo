//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import Foundation
import RxSwift

// 기본적인 CRUD를 처리하는 프로토콜을 정의
protocol MemoStorageType {
    @discardableResult
    func createMemo(content: String) -> Observable<MemoModel>
    
    @discardableResult
    func memoList() -> Observable<[MemoModel]>
    
    @discardableResult
    func updateMemo(memo: MemoModel, content: String) -> Observable<MemoModel>
    
    @discardableResult
    func deleteMemo(memo: MemoModel) -> Observable<MemoModel>
}
