//
//  MovieCollection.swift
//  New-Movies-In-Cinema
//
//  Created by Florentin Lupascu on 30/07/18.
//  Copyright © 2018 Florentin Lupascu. All rights reserved.
//

import Foundation

struct MovieCollection {
    
    var id: Int
    var name: String
    
    var overview: String?
    var parts: [Movie]?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
