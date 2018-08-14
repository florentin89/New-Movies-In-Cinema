//
//  MovieCollectionViewCell.swift
//  New-Movies-In-Cinema
//
//  Created by Florentin Lupascu on 30/07/18.
//  Copyright © 2018 Florentin Lupascu. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func set(movie: Movie) {
        self.imageView.sd_cancelCurrentImageLoad()
        self.imageView.image = nil
        
        if let string = NetworkServices.shared.getImageURL(for: movie.posterPath),
            let url = URL(string: string) {
            self.imageView.sd_setImage(with: url)
        }
    }
}
