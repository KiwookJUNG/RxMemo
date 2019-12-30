//
//  MemoModel.swift
//  RxMemo
//
//  Created by 정기욱 on 2019/11/20.
//  Copyright © 2019 kiwook. All rights reserved.
//

import Foundation
import RxDataSources

// 데이터 소스에 저장되는 모든 데이터는 IdentifiableType 프로토콜을 채용해야함
struct MemoModel: Equatable, IdentifiableType {
    var content: String
    var insertDate: Date
    var identity: String
    
    init(content: String, insertDate: Date = Date()) {
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    
    init(original: MemoModel, updateContent: String) {
        self = original
        self.content = updateContent
    }
}
