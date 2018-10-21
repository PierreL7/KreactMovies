//
//  SimilarMovieCollectionViewCell.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 22/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit
import Cosmos

class SimilarMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var MoviePicture : UIImageView!
    @IBOutlet weak var MovieName : UILabel!
    @IBOutlet weak var Rating : CosmosView!
}
