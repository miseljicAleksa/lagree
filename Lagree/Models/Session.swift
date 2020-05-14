//
//  Session.swift
//  Lagree
//
//  Created by Arsen Leontijevic on 9/26/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import Foundation

struct Session {
    
    var json: JSON
    
    
    init(json: JSON) {
        self.json = json
    }
    var imageUrl: String? {
        return json["imageUrl"].string
    }
    var name: String? {
        return json["name"].string
    }
    var date: String? {
        return json["date"].string
    }
    var studio: String? {
        return json["studio"].string
    }
    var instructor: String? {
        return json["instructor"].string
    }
    
}
