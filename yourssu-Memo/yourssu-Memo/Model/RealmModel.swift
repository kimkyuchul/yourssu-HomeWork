//
//  RealmModel.swift
//  yourssu-Memo
//
//  Created by qualson1 on 2022/10/06.
//

import Foundation
import RealmSwift

class Memo: Object {
    
    @Persisted var title: String
    @Persisted var content: String
    @Persisted var createdDate: Date
    @Persisted var updatedDate: Date
    
    @Persisted(primaryKey: true) var _id: ObjectId // primaryKey
    
    
    convenience init(title: String, content: String, createdDate: Date, updatedDate: Date) {
        self.init()
        
        self.title = title
        self.content = content
        self.createdDate = createdDate
        self.updatedDate = updatedDate
    }
}
