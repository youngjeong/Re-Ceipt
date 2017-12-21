//
//  User.swift
//  Re-Ceipt
//
//  Created by Sunwoo Lee on 2017. 12. 16..
//  Copyright © 2017년 SSU. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var username: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        username <- map["username"]
    }
}
