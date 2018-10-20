//
//  JSONDecoder.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 19/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

struct Movies: Decodable {
    let page: Int
    let total_results : Int
    let total_pages : Int
    let results : [Result]
}

struct Result: Decodable {
    let vote_count : Int
    let id : Int
    let video : Bool
    let vote_average : Float
    let title : String
    let popularity : Float
    let poster_path : String
    let original_language : String
    let original_title : String
    let adult : Bool
    let overview : String
    let release_date : String
}

protocol MovieDelegate {

    func movieListReceived(list: [Movie])
    
}

class JSONReader: NSObject {
    
    static var _sharedInstance: JSONReader = JSONReader()
    var delegate : MovieDelegate?
    
    func decodeCurrentMovies(withData: Data) {
        var movieList = [Movie]()
        do {
            let movies = try JSONDecoder().decode(Movies.self, from: withData)
            movies.results.forEach { (m) in
                let movie = Movie()
                movie.Title = m.title
                APIManager._sharedInstance.downloadImages(from: m.poster_path, with: movie)
                movie.Overview = m.overview
                movie.releaseDate = m.release_date
                movieList.append(movie)
            }
            delegate?.movieListReceived(list: movieList)
        } catch let jsonErr {
            print(jsonErr)
        }
    }
}
