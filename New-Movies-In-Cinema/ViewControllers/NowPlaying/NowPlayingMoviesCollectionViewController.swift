//
//  NowPlayingMoviesCollectionViewController.swift
//  New-Movies-In-Cinema
//
//  Created by Florentin Lupascu on 30/07/18.
//  Copyright © 2018 Florentin Lupascu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NowPlayingMoviesCollectionViewController: UICollectionViewController {
    
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        let nib = UINib(nibName: "MovieCollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.loadNowPlayingMovies()
    }
    
    private func loadNowPlayingMovies() {
        NetworkServices.shared.getMovies { (movies) in
            self.movies = movies
            self.collectionView!.reloadData()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destiantion = segue.destination as? MovieDetailsViewController,
            segue.identifier == "showMovieDetails",
            let movie = sender as? Movie {
            destiantion.movie = movie
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        // Configure the cell
        cell.set(movie: self.movies[indexPath.item])
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showMovieDetails", sender: self.movies[indexPath.item])
    }
    
}

extension NowPlayingMoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 1) / 2
        let height = width / 0.6654676259
        return CGSize(width: width, height: height)
    }
}
