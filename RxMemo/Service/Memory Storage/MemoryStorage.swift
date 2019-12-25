//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import Foundation
import RxSwift

class MemoryStorage: MemoStorageType {
    private var list: [MemoModel] = [
        MemoModel(content: "첫 번째 메모", insertDate: Date().addingTimeInterval(-10)),
        MemoModel(content: "두 번째 메모", insertDate: Date().addingTimeInterval(-20))
    ]
    private lazy var store = BehaviorSubject<[MemoModel]>(value: list)
    
    @discardableResult
    func createMemo(content: String) -> Observable<MemoModel> {
        let memo = MemoModel(content : content)
        list.insert(memo, at: 0)
        
        // list에 새로운 메모를 insert한 후 BehaviorSubject인 store의 새로운 이벤트를 방출한다. ( onNext )
        store.onNext(list)
        // 새로만들어진 메모를 방출하는 옵저버블을 리턴한다.
        return Observable.just(memo)
    }
    
    @discardableResult
    func memoList() -> Observable<[MemoModel]> { return store }
    
    @discardableResult
    func updateMemo(memo: MemoModel, content: String) -> Observable<MemoModel> {
        let updated = MemoModel(original: memo, updateContent: content)
        
        // list에 저장된 원본을 업데이트 된 것으로 교체
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        // list가 새로 업데이트 된 것으로 바꼈으니 BehaviorSubject에서 새로운 이벤트를 방출한다.
        store.onNext(list)
        
        return Observable.just(updated)
    }
    
    @discardableResult
    func deleteMemo(memo: MemoModel) -> Observable<MemoModel> {
        // list에서 해당하는 메모를 삭제
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
        }
        // subject에서 메모가 삭제된 리스트를 방출
        store.onNext(list)
        // 삭제한 메모 방출
        return Observable.just(memo)
    }
}
