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
    var pk: Int?
    var author: User?
    var created: String?
    var modified: String?
    var title: String?
    var spend_list: [Spend]?
    var start_idx: String?
    var end_idx: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        pk <- map["pk"]
        author <- map["author"]
        created <- map["created"]
        modified <- map["modified"]
        title <- map["title"]
        spend_list <- map["spend_list"]
        start_idx <- map["start_idx"]
        end_idx <- map["end_idx"]
    }
}
