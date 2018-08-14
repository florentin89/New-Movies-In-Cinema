//
//  MovieCollectionsCollectionViewAdapter.swift
//  New-Movies-In-Cinema
//
//  Created by Florentin Lupascu on 30/07/18.
//  Copyright © 2018 Florentin Lupascu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MovieCollectionsCollectionViewAdapter: NSObject, UICollectionViewDataSource {
    
    private var movies: [Movie] = []
    private var collectionView: UICollectionView!
    
    var didSelectMovie: ((Movie) -> Void)?
    
    init(with movies: [Movie], collectionView: UICollectionView) {
        super.init()
        self.movies = movies
        self.set(collectionView: collectionView)
    }
    
    private func set(collectionView: UICollectionView) {
        self.collectionView = collectionView
        
        // Register cell classes
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        cell.set(movie: self.movies[indexPath.item])
        return cell
    }
}

extension MovieCollectionsCollectionViewAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectMovie?(self.movies[indexPath.item])
    }
}
