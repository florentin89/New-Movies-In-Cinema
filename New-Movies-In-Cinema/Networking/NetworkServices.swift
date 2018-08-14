//
//  NetworkServices.swift
//  New-Movies-In-Cinema
//
//  Created by Florentin Lupascu on 30/07/18.
//  Copyright © 2018 Florentin Lupascu. All rights reserved.
//

import Foundation
import Alamofire

class NetworkServices {
    
    static let shared: NetworkServices = NetworkServices()
    
    private let MOVIE_DB_API_KEY: String = "4f811f64687fc0038b16d5c4a8749c15"
    
    enum Services: String {
        case nowPlaying = "movie/now_playing"
        case movieDetails = "movie"
        case collectionDetails = "collection"
    }
    
    func createURLComponents(for service: Services) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.themoviedb.org"
        
        let apiVersion = "3"
        let serviceName = service.rawValue
        components.path = "/\(apiVersion)/\(serviceName)"
        
        components.queryItems = [ URLQueryItem(name: "api_key", value: self.MOVIE_DB_API_KEY) ]
        return components
    }
    
    func getMovies(_ completion: @escaping (([Movie])->Void)) {
        
        let url = self.createURLComponents(for: NetworkServices.Services.nowPlaying).url!
        Alamofire.request(url).responseJSON { (rawResponse) in
            
            guard let response = rawResponse.result.value as? [String:Any],
                let rawMovies = response["results"] as? [[String:Any]]  else {
                    // Error here
                    return
            }
            
            var movies: [Movie] = []
            for rawMovie in rawMovies {
                if let movie = self.movie(from: rawMovie) {
                    movies.append(movie)
                }
            }
            
            DispatchQueue.main.async {
                completion(movies)
            }
        }
    }
    
    func movie(from raw: [String:Any]) -> Movie? {
        guard let id = raw["id"] as? Int else {
            return nil
        }
        
        guard let averageVotes = raw["vote_average"] as? Double else {
            return nil
        }
        
        guard let popularity = raw["popularity"] as? Double else {
            return nil
        }
        
        guard let title = raw["title"] as? String else {
            return nil
        }
        
        guard let originalTitle = raw["original_title"] as? String else {
            return nil
        }
        
        guard let overview = raw["overview"] as? String else {
            return nil
        }
        
        guard let releaseDate = raw["release_date"] as? String else {
            return nil
        }
        
        guard let adult = raw["adult"] as? Bool else {
            return nil
        }
        
        let posterPath = raw["poster_path"] as? String
        
        var collection: MovieCollection?
        if let rawCollection = raw["belongs_to_collection"] as? [String:Any],
            let collectionId = rawCollection["id"] as? Int,
            let collectionName = rawCollection["name"] as? String {
            collection = MovieCollection(id: collectionId, name: collectionName)
        }
        
        let movie = Movie(id: id,
                          averageVotes: averageVotes,
                          popularity: popularity,
                          title: title,
                          originalTitle: originalTitle,
                          overview: overview,
                          releaseDate: releaseDate,
                          adult: adult,
                          posterPath: posterPath,
                          collection: collection)
        return movie
    }
    
    func getImageURL(for posterPath: String?) -> String? {
        guard let posterPath = posterPath else {
            return nil
        }
        return "https://image.tmdb.org/t/p/w185/\(posterPath)"
    }
    
    func getMovieDetails(movie: Movie, _ completion: @escaping ((Movie?)->Void)) {
        
        var components = self.createURLComponents(for: NetworkServices.Services.movieDetails)
        components.path += "/\(movie.id)"
        let url = components.url!
        
        Alamofire.request(url).responseJSON { (rawResponse) in
            
            guard let rawMovie = rawResponse.result.value as? [String:Any]  else {
                    // Error here
                    return
            }
            
            let movie = self.movie(from: rawMovie)
            DispatchQueue.main.async {
                completion(movie)
            }
        }
    }
    
    func getMovieCollections(collection: MovieCollection, _ completion: @escaping ((MovieCollection?)->Void)) {
        
        var components = self.createURLComponents(for: NetworkServices.Services.collectionDetails)
        components.path += "/\(collection.id)"
        let url = components.url!
        
        Alamofire.request(url).responseJSON { (rawResponse) in
            
            guard let response = rawResponse.result.value as? [String:Any] else {
                // Error here
                return
            }
            
            let collection = self.movieCollection(from: response)
            
            DispatchQueue.main.async {
                completion(collection)
            }
        }
    }
    
    func movieCollection(from raw: [String:Any]) -> MovieCollection? {
        guard let id = raw["id"] as? Int else {
            return nil
        }
        
        guard let name = raw["name"] as? String else {
            return nil
        }
        
        guard let parts = raw["parts"] as? [[String:Any]] else {
            return nil
        }
        
        var movies: [Movie] = []
        for rawMovie in parts {
            if let movie = self.movie(from: rawMovie) {
                movies.append(movie)
            }
        }
        
        var collection = MovieCollection(id: id, name: name)
        collection.parts = movies
        return collection
    }
}
