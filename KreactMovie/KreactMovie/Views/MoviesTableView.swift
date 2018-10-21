//
//  MoviesTableView.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 19/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

struct CellData {
    let movieImage : UIImage?
    let title : String?
}

protocol MovieDetails {
    func showMovieDetails(movie: Movie)
}

class MoviesTableView: UIView {

    @IBOutlet weak var tableView : UITableView!
    var data = [CellData]()
    var movieDetailsDelegate : MovieDetails?
    var movieList = [Movie]()
    
    func createTableView(movies : [Movie]) {
        tableView.delegate = self
        tableView.dataSource = self
        movieList = movies
        movies.forEach { (movie) in
            data.append(CellData.init(movieImage: movie.Poster, title: movie.Title))
        }
        self.tableView.register(MovieCustomCellTableViewCell.self, forCellReuseIdentifier: "movieCell")
        self.tableView.rowHeight = UITableView.automaticDimension   //resize cell to its content
        self.tableView.addSubview(refreshControl)
    }
    
    func reloadTableView(movies : [Movie]) {
        data.removeAll()
        movieList = movies
        movies.forEach { (movie) in
            data.append(CellData.init(movieImage: movie.Poster, title: movie.Title))
        }
        self.tableView.register(MovieCustomCellTableViewCell.self, forCellReuseIdentifier: "movieCell")
        self.tableView.reloadData()
    }
    
    func findMovieByName(name: String) -> Movie? {
        // Seeking for the first occurence of the title
        if let movie = movieList.first(where: {$0.Title == name}) {
            return movie
        } else {
            return nil
        }
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

//Delegates Functions
extension MoviesTableView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCustomCellTableViewCell
        
        cell.movieImage = data[indexPath.row].movieImage
        cell.title = data[indexPath.row].title
        if indexPath.row % 2 != 0 {
            cell.backgroundColor = UIColor(red: 105, green: 168, blue: 79).withAlphaComponent(0.5)
        } else {
            cell.backgroundColor = .white
        }
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let name = data[indexPath.row].title {
            guard let movie = findMovieByName(name: name) else {return}
            movieDetailsDelegate?.showMovieDetails(movie: movie)
        }
    }
}
