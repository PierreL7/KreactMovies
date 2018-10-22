//
//  MovieCustomCellTableViewCell.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 19/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

class MovieCustomCellTableViewCell: UITableViewCell {
    
    var movieImage : UIImage?
    var movieLogo : UIImage?
    var title : String?
    
    var titleView : UILabel = {
        var labelView = UILabel()
        labelView.lineBreakMode = .byWordWrapping
        labelView.numberOfLines = 2
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
   
    var movieImageView : UIImageView = {
       var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var movieLogoView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.addSubview(movieImageView)
        self.addSubview(titleView)
        self.addSubview(movieLogoView)
        setViewsAnchors()
    }
    
    func setViewsAnchors() {
        movieImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        movieImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        movieLogoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        movieLogoView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        movieLogoView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        movieLogoView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.05).isActive = true
        
        titleView.rightAnchor.constraint(equalTo: self.movieLogoView.leftAnchor).isActive = true
        titleView.leftAnchor.constraint(equalTo: self.movieImageView.rightAnchor, constant: 15).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let title = title, let image = movieImage, let logo = movieLogo {
            titleView.text = title
            movieImageView.image = image
            movieLogoView.image = logo
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
