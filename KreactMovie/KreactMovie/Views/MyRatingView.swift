//
//  MyRatingView.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 23/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit
import Cosmos

class MyRatingView: UIView {

    @IBOutlet weak var rateMovieView : CosmosView!
    
    func rateMovie(movie: Movie) {
        rateMovieView.rating = 0.0
        rateMovieView.didFinishTouchingCosmos = {rating in
            movie.movieRating = rating
        }
    }
}
