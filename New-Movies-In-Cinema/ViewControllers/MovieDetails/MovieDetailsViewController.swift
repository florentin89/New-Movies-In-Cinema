//
//  MovieDetailsViewController.swift
//  New-Movies-In-Cinema
//
//  Created by Florentin Lupascu on 30/07/18.
//  Copyright © 2018 Florentin Lupascu. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movie: Movie!
    var collectionsAdapter: MovieCollectionsCollectionViewAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkServices.shared.getMovieDetails(movie: self.movie, { (movie) in
            self.movie = movie
            self.showMovieDetails()
        })
    }
    
    private func showMovieDetails() {
        
        self.collectionNameLabel.text = self.movie.collection?.name ?? ""
        self.loadMovieCollection()
        
        if let string = NetworkServices.shared.getImageURL(for: self.movie.posterPath),
            let url = URL(string: string) {
            self.moviePosterImageView.sd_setImage(with: url)
        }
        
        self.titleLabel.text = self.movie.title
        self.overviewTextView.text = self.movie.overview
    }
    
    private func loadMovieCollection() {
        if let collection = self.movie.collection {
            NetworkServices.shared.getMovieCollections(collection: collection, { (collection) in
                guard let movies = collection?.parts else {
                    return
                }
                self.collectionsAdapter = MovieCollectionsCollectionViewAdapter(with: movies, collectionView: self.collectionView)
                self.collectionsAdapter?.didSelectMovie = { selectedMovie in
                    self.performSegue(withIdentifier: "showMovieDetails", sender: selectedMovie)
                }
            })
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destiantion = segue.destination as? MovieDetailsViewController,
            segue.identifier == "showMovieDetails",
            let movie = sender as? Movie {
            destiantion.movie = movie
        }
    }
}
