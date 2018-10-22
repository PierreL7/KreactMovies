//
//  APIManager.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 19/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    static var _sharedInstance: APIManager = APIManager()
    
    private let theMovieDbUrl : String = "https://api.themoviedb.org/"
    private let imageUrl : String = "https://image.tmdb.org/t/p/"
    private let apiKey : String = "daa8d287ad543aa14c94ea12c0717f87"

    
    func getCurrentMovies() {
        
        let todayDate = Date()
        let beginDate = Calendar.current.date(byAdding: .month, value: -1, to: todayDate)!
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        guard let urlToCall = URL(string: "\(theMovieDbUrl)/3/discover/movie?primary_release_date.gte=\(dateFormatterGet.string(from: beginDate))&primary_release_date.lte=\(dateFormatterGet.string(from: todayDate))&api_key=\(apiKey)") else {return}
        
        // check if url is valid
        if UIApplication.shared.canOpenURL(urlToCall) {
            var request = URLRequest(url: urlToCall)
            request.httpMethod = "GET"
                
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let receivedData = data {
                    if !JSONReader._sharedInstance.decodeCurrentMovies(withData: receivedData) {
                        return
                    }
                }
            }
            task.resume()
        }
    }
    
    func getMovieCreditsByID(id: Int) {
        guard let urlToCall = URL(string: "\(theMovieDbUrl)/3/movie/\(id)/credits?api_key=\(apiKey)") else {return}
        if UIApplication.shared.canOpenURL(urlToCall) {
            var request = URLRequest(url: urlToCall)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let receivedData = data {
                    if !JSONReader._sharedInstance.decodeMovieCredits(withData: receivedData) {
                        return
                    }
                }
            }
            task.resume()
        }
    }
    
    func getSimilarMovies(id: Int) {
        guard let urlToCall = URL(string: "\(theMovieDbUrl)/3/movie/\(id)/similar?api_key=\(apiKey)") else {return}
        if UIApplication.shared.canOpenURL(urlToCall) {
            var request = URLRequest(url: urlToCall)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let receivedData = data {
                    if !JSONReader._sharedInstance.decodeSimilarMovies(withData: receivedData) {
                        return
                    }
                }
            }
            task.resume()
        }
    }
    
    func getTrailerByMovieId(id: Int) {
        guard let urlToCall = URL(string: "\(theMovieDbUrl)/3/movie/\(id)/videos?api_key=\(apiKey)") else {return}
        if UIApplication.shared.canOpenURL(urlToCall) {
            var request = URLRequest(url: urlToCall)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let receivedData = data {
                    if !JSONReader._sharedInstance.decodeTrailer(withData: receivedData) {
                        return
                    }
                }
            }
            task.resume()
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadPoster(from path : String, with width : String, with movie : Movie) {
        movie.Poster = UIImage(named: "kreactMovieLogo")
        guard let url = URL(string: "\(imageUrl)/\(width)/\(path)") else {return}
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            movie.Poster = UIImage(data: data)
        }
    }
    
    func downloadBackdrop(from path : String, with width : String, with movie : Movie) {
        guard let url = URL(string: "\(imageUrl)/\(width)/\(path)") else {return}
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            movie.Backdrop = UIImage(data: data)
        }
    }
    
    func downloadPicture(from path : String, with width : String, with actor : Actor) {
        actor.Picture = UIImage(named: "unknown")
        if path == "unknown" {
            actor.Picture = UIImage(named: path)
            return
        }
        guard let url = URL(string: "\(imageUrl)/\(width)/\(path)") else {return}
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            actor.Picture = UIImage(data: data)
        }
    }
}
