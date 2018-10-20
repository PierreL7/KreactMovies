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
    private let imageUrl : String = "https://image.tmdb.org/t/p/w92/"
    private let apiKey : String = "daa8d287ad543aa14c94ea12c0717f87"

    
    func getCurrentMovies() {
        
        guard let urlToCall = URL(string: "\(theMovieDbUrl)/3/discover/movie?primary_release_date.gte=2018-10-01&primary_release_date.lte=2018-10-19&api_key=\(apiKey)") else {return}
        
        // check if url is valid
        if UIApplication.shared.canOpenURL(urlToCall) {
            var request = URLRequest(url: urlToCall)
            request.httpMethod = "GET"
                
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let receivedData = data {
                    JSONReader._sharedInstance.decodeCurrentMovies(withData: receivedData)
                }
            }
            task.resume()
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImages(from path : String, with movie : Movie) {
        guard let url = URL(string: "\(imageUrl)\(path)") else {return}
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            movie.Image = UIImage(data: data)
        }
    }
}
