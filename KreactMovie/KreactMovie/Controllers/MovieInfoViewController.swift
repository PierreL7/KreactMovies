//
//  MovieInfoViewController.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 20/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    @IBOutlet weak var mainInfo : MovieMainInfoView!
    @IBOutlet weak var trailerView : TrailerView!
    @IBOutlet weak var synopsisView : SynopsisView!
    @IBOutlet weak var castingView : CastingCollectionView!
    @IBOutlet weak var similarMoviesView : SimilarMovieCollectionView!

    var movie : Movie!
    var actors : [Actor]!
    var crewMembers : [CrewMember]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        JSONReader._sharedInstance.crewDelegate = self
        JSONReader._sharedInstance.trailerDelegate = self
        JSONReader._sharedInstance.movieDelegate = self
        
        if let movieId = movie.Id {
            APIManager._sharedInstance.getMovieCreditsByID(id: movieId)
            APIManager._sharedInstance.getTrailerByMovieId(id: movieId)
            APIManager._sharedInstance.getSimilarMovies(id: movieId)
        }
        if let synopsis = movie.Overview {
            synopsisView.setSynopsis(synopsis: synopsis)
        }
        mainInfo.mainInfo(movie: movie)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func findCrewMemberByJob(job: String) -> String? {
        if let name = crewMembers.first(where: {$0.Job == job}) {
            return name.Name
        } else {
            return nil
        }
    }
    
    @IBAction func backToBoxOffice(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//Delegates Functions
extension MovieInfoViewController: CrewDelegate, TrailerDelegate, MovieDelegate {
    
    func movieListReceived(list: [Movie]) {
        DispatchQueue.main.async {
            if !list.isEmpty {
                self.similarMoviesView.createSimilarMovieView(_movies: list)
            }
        }
    }
    
    func trailerReceived(videoKey: String, site: String) {
        trailerView.getTrailer(videoKey: videoKey)
    }
    
    func crewReceived(actorList: [Actor], crewMemberList: [CrewMember]) {
        actors = actorList
        crewMembers = crewMemberList
        DispatchQueue.main.async {
            self.mainInfo.From.text = self.findCrewMemberByJob(job: "Director")
            self.castingView.createCastingView(_actors: self.actors)
        }
    }
}
