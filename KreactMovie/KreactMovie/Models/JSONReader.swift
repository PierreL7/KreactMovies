//
//  JSONDecoder.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 19/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

struct SimilarMovies : Decodable {
    let results : [Result]
}

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
    let vote_average : Double
    let title : String
    let popularity : Double
    let poster_path : String?
    let original_language : String
    let original_title : String
    let adult : Bool
    let overview : String
    let release_date : String
    let backdrop_path : String?
}

struct Credits: Decodable {
    let id : Int
    let cast : [CastMember]
    let crew : [CrewM]
}

struct CastMember: Decodable {
    let cast_id : Int
    let character : String
    let credit_id : String
    let gender : Int
    let id : Int
    let name : String
    let order : Int
    let profile_path : String?
}

struct CrewM: Decodable {
    let credit_id : String
    let department : String
    let gender : Int
    let id : Int
    let job : String
    let name : String
    let profile_path : String?
}

struct Trailer: Decodable {
    let id : Int
    let results: [TrailerInfos]
}

struct TrailerInfos: Decodable {
    let key : String
    let name : String
    let site : String
}

protocol MovieDelegate {
    func movieListReceived(list: [Movie])
}

protocol CrewDelegate {
    func crewReceived(actorList: [Actor], crewMemberList: [CrewMember])
}

protocol TrailerDelegate {
    func trailerReceived(videoKey: String, site: String)
}

class JSONReader: NSObject {
    
    static var _sharedInstance: JSONReader = JSONReader()
    var movieDelegate : MovieDelegate?
    var crewDelegate : CrewDelegate?
    var trailerDelegate : TrailerDelegate?
    
    func decodeSimilarMovies(withData: Data) -> Bool {
        var movieList = [Movie]()
        do {
            let movies = try JSONDecoder().decode(SimilarMovies.self, from: withData)
            movies.results.forEach { (m) in
                let movie = Movie()
                movie.Title = m.title
                APIManager._sharedInstance.downloadPoster(from: m.poster_path ?? "unknown", with: "w154", with: movie)
                movie.voteAverage = m.vote_average
                movieList.append(movie)
            }
            movieDelegate?.movieListReceived(list: movieList)
        } catch let jsonErr {
            print(jsonErr)
            return false
        }
        return true
    }
    
    func decodeCurrentMovies(withData: Data) -> Bool {
        var movieList = [Movie]()
        do {
            let movies = try JSONDecoder().decode(Movies.self, from: withData)
            movies.results.forEach { (m) in
                let movie = Movie()
                movie.Title = m.title
                guard let poster = m.poster_path else {return}
                APIManager._sharedInstance.downloadPoster(from: poster, with: "w154", with: movie)
                APIManager._sharedInstance.downloadBackdrop(from: m.backdrop_path ?? poster, with: "w500", with: movie)
                movie.Overview = m.overview
                movie.releaseDate = m.release_date
                movie.Id = m.id
                movie.Popularity = m.popularity
                movie.voteAverage = m.vote_average
                movieList.append(movie)
            }
            movieDelegate?.movieListReceived(list: movieList)
        } catch let jsonErr {
            print(jsonErr)
            return false
        }
        return true
    }
    
    func decodeMovieCredits(withData: Data) -> Bool {
        var actorList = [Actor]()
        var crewMemberList = [CrewMember]()
        do {
            let credits = try JSONDecoder().decode(Credits.self, from: withData)
            credits.cast.forEach { (castMember) in
                let actor = Actor()
                actor.Name = castMember.name
                actor.Character = castMember.character
                actor.picturePath = castMember.profile_path
                actorList.append(actor)
            }
            credits.crew.forEach { (crewM) in
                let crewMember = CrewMember()
                crewMember.Name = crewM.name
                crewMember.Job = crewM.job
                crewMember.picturePath = crewM.profile_path
                crewMemberList.append(crewMember)
            }
            crewDelegate?.crewReceived(actorList: actorList, crewMemberList: crewMemberList)
        } catch let jsonErr {
            print(jsonErr)
            return false
        }
        return true
    }
    
    func decodeTrailer(withData: Data) -> Bool {
        do {
            let trailers = try JSONDecoder().decode(Trailer.self, from: withData)
            if let videoKey = trailers.results.first?.key {
                trailerDelegate?.trailerReceived(videoKey: videoKey, site: trailers.results.first?.site ?? "youtube")
            }
        } catch let jsonErr {
            print(jsonErr)
            return false
        }
        return true
    }
}
