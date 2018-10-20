//
//  MovieMainInfoView.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 20/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit
import Cosmos

class MovieMainInfoView: UIView {

    @IBOutlet weak var Title : UILabel!
    @IBOutlet weak var releaseDate : UILabel!
    @IBOutlet weak var From : UILabel!
    @IBOutlet weak var Image : UIImageView!
    @IBOutlet weak var Popularity : UILabel!
    @IBOutlet weak var Rating : CosmosView!
    @IBOutlet weak var RatingLabel : UILabel!

    func mainInfo(movie : Movie) {
        Title.text = movie.Title
        Image.image = movie.Backdrop
        releaseDate.text = movie.releaseDate
        Rating.settings.updateOnTouch = false
        guard let rate = movie.voteAverage else {return}
        Rating.rating = rate / 2
        RatingLabel.text = String(rate / 2)
        guard let popularity = movie.Popularity else {return}
        Popularity.text = String(popularity)
    }
}
