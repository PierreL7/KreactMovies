//
//  KreactMovieTests.swift
//  KreactMovieTests
//
//  Created by Pierre Lefebvre on 19/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import XCTest
@testable import KreactMovie

class KreactMovieTests: XCTestCase {
    
    func testGetData(){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w45/kqjL17yufvn9OVLyXYpvtyrFfak.jpg") else {return}
        APIManager._sharedInstance.getData(from: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
        }
    }
    
    func testDecodeCredits() {
        guard let creditsURL = URL(string: "https://api.themoviedb.org/3/movie/335983/credits?api_key=daa8d287ad543aa14c94ea12c0717f87") else {return}
        if UIApplication.shared.canOpenURL(creditsURL) {
            var request = URLRequest(url: creditsURL)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let receivedData = data {
                    XCTAssertTrue(JSONReader._sharedInstance.decodeMovieCredits(withData: receivedData))
                }
            }
        }
    }
    
    func testDecodeMovies() {
         guard let currentMovieUrl = URL(string: "https://api.themoviedb.org/3/movie/335983/?primary_release_date.gte=2018-10-01&primary_release_date.lte=2018-10-20&api_key=daa8d287ad543aa14c94ea12c0717f87") else {return}
        if UIApplication.shared.canOpenURL(currentMovieUrl) {
            var request = URLRequest(url: currentMovieUrl)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let receivedData = data {
                    XCTAssertTrue(JSONReader._sharedInstance.decodeCurrentMovies(withData: receivedData))
                }
            }
        }
    }
    
    func testDecodeSimilarMovies() {
         guard let similarMovieUrl = URL(string: "https://api.themoviedb.org/3/movie/335983/similar?api_key=daa8d287ad543aa14c94ea12c0717f87") else {return}
        if UIApplication.shared.canOpenURL(similarMovieUrl) {
            var request = URLRequest(url: similarMovieUrl)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let receivedData = data {
                    XCTAssertTrue(JSONReader._sharedInstance.decodeSimilarMovies(withData: receivedData))
                }
            }
        }
    }
    
    
    func testDecodeTrailer() {
         guard let trailerUrl = URL(string: "https://api.themoviedb.org/3/movie/335983/video?api_key=daa8d287ad543aa14c94ea12c0717f87") else {return}
        if UIApplication.shared.canOpenURL(trailerUrl) {
            var request = URLRequest(url: trailerUrl)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let receivedData = data {
                    XCTAssertTrue(JSONReader._sharedInstance.decodeTrailer(withData: receivedData))
                }
            }
        }
    }
}
