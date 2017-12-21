//
//  Post.swift
//  Re-Ceipt
//
//  Created by 유영정 on 2017. 12. 20..
//  Copyright © 2017년 SSU. All rights reserved.
//

import Foundation
import ObjectMapper

class Post: Mappable {
    var id: Int?
    var author: User?
    var created: String?
    var modified: String?
    var title: String?
    var spend_list: [Spend]?
    var start_date: String?
    var end_date: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        author <- map["author"]
        created <- map["created"]
        modified <- map["modified"]
        title <- map["title"]
        spend_list <- map["spend_list"]
        start_date <- map["start_date"]
        end_date <- map["end_date"]
    }
}
