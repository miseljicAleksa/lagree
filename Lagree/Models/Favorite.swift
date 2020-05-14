//
//  Favorite.swift
//  Lagree
//
//  Created by Arsen Leontijevic on 9/26/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import Foundation

struct Favorite {
    
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

}
