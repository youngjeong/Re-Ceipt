//
//  Comment.swift
//  Re-Ceipt
//
//  Created by 유영정 on 2017. 12. 21..
//  Copyright © 2017년 SSU. All rights reserved.
//

import Foundation
import ObjectMapper

class Comment: Mappable {
    var author: User?
    var content: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        content <- map["content"]
        author <- map["author"]
        
    }
    
    
    
}