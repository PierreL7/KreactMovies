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
    var movieResearch = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarView.searchBar.delegate = self
        searchBarView.removeSearchBarBackground()
        moviesTableView.movieDetailsDelegate = self
        moviesTableView.createTableView(movies: movieList)
        searchBarView.searchBar.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowMovieDetails") {
            if let destVC = segue.destination as? MovieInfoViewController {
                destVC.movie = movieSelected
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//Delegates functions
extension BoxOfficePageViewController : MovieDetails, UISearchBarDelegate {
    
    func showMovieDetails(movie: Movie) {
        movieSelected = movie
        self.performSegue(withIdentifier: "ShowMovieDetails", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieResearch = movieList.filter({ movie -> Bool in
            guard let title = movie.Title else {return false}
            print(title.contains(searchText))
            return title.contains(searchText)
        })
        if movieResearch.isEmpty {
            movieResearch = movieList
        }
        moviesTableView.reloadTableView(movies: movieResearch)
    }
    
    //close keyboard on search button tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
