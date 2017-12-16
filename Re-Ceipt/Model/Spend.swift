//
//  Spend.swift
//  Re-Ceipt
//
//  Created by Sunwoo Lee on 2017. 12. 16..
//  Copyright © 2017년 SSU. All rights reserved.
//

import Foundation
import ObjectMapper

class Spend: Mappable {
    var pk: Int?
    var author: String?
    var created: String?
    var modified: String?
    var title: String?
    var type: String?
    var amount: Int?
    var photo_path: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        pk <- map["pk"]
        author <- map["author.username"]
        created <- map["created"]
        modified <- map["modified"]
        title <- map["title"]
        type <- map["type"]
        amount <- map["amount"]
        photo_path <- map["photo_path"]
    }
    
    
    
}
//class Spend {
//    var pk: Int
//    var author: String
//    var created: String
//    var modified: String
//    var title: String
//    var type: String
//    var amount: Int
//    var photo_path: String
//
//    init(pk: Int, author: String, created: String, modified: String, title: String, type: String, amount: Int, photo_path: String) {
//        self.pk = pk
//        self.author = author
//        self.created = created
//        self.modified = modified
//        self.title = title
//        self.type = type
//        self.amount = amount
//        self.photo_path = photo_path
//    }
//}

