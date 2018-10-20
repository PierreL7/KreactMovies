//
//  BoxOfficePageViewController.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 19/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

class BoxOfficePageViewController: UIViewController {

    @IBOutlet weak var searchBarView : SearchBarView!
    @IBOutlet weak var moviesTableView : MoviesTableView!
    var movieList = [Movie]()
    var movieSelected : Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarView.removeSearchBarBackground()
        moviesTableView.movieDetailsDelegate = self
        moviesTableView.createTableView(movies: movieList)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowMovieDetails") {
            if let destVC = segue.destination as? MovieInfoViewController {
                destVC.movie = movieSelected
            }
        }
    }
}

//Delegates functions
extension BoxOfficePageViewController : MovieDetails {
    
    func showMovieDetails(movie: Movie) {
        movieSelected = movie
        self.performSegue(withIdentifier: "ShowMovieDetails", sender: self)
    }
}
