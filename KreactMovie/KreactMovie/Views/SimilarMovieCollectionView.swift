//
//  similarMovieCollectionView.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 21/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

class SimilarMovieCollectionView: UICollectionView,UICollectionViewDelegate, UICollectionViewDataSource {

    var movies = [Movie]()
    
    func createSimilarMovieView(_movies: [Movie]) {
        self.dataSource = self
        self.delegate = self
        movies = _movies
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "SimilarMovieCell", for: indexPath) as! SimilarMovieCollectionViewCell
        
        cell.MovieName.text = movies[indexPath.row].Title
        cell.MoviePicture.image = movies[indexPath.row].Poster
        
        if let rate =  movies[indexPath.row].voteAverage {
            cell.Rating.rating = rate / 2
        } else {
            cell.Rating.rating = 0.0
        }
        
        return cell
    }
}
