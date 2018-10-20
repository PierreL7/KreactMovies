//
//  MovieMainInfoView.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 20/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

class MovieMainInfoView: UIView {

    @IBOutlet weak var Title : UILabel!
    @IBOutlet weak var releaseDate : UILabel!
    @IBOutlet weak var From : UILabel!
    @IBOutlet weak var Image : UIImageView!

    func mainInfo(movie : Movie) {
        Title.text = movie.Title
        Image.image = movie.Backdrop
        releaseDate.text = movie.releaseDate
    }
}
