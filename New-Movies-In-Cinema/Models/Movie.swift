//
//  Movie.swift
//  New-Movies-In-Cinema
//
//  Created by Florentin Lupascu on 30/07/18.
//  Copyright © 2018 Florentin Lupascu. All rights reserved.
//

import Foundation

struct Movie {
    
    var id: Int
    var averageVotes: Double
    var popularity: Double
    
    var title: String
    var originalTitle: String
    var overview: String
    var releaseDate: String
    
    var adult: Bool
    
    var posterPath: String?

    var collection: MovieCollection?
}
