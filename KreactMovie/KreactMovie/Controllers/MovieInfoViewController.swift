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
    var movie : Movie!
    var actors : [Actor]!
    var crewMembers : [CrewMember]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        JSONReader._sharedInstance.crewDelegate = self
        if let movieId = movie.Id {
            APIManager._sharedInstance.getMovieCreditsByID(id: movieId)
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
}

//Delegates Functions
extension MovieInfoViewController: CrewDelegate {
    
    func crewReceived(actorList: [Actor], crewMemberList: [CrewMember]) {
        actors = actorList
        crewMembers = crewMemberList
        DispatchQueue.main.async {
            self.mainInfo.From.text = self.findCrewMemberByJob(job: "Director")
        }
    }
}
