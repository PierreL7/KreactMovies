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
    var title : String?
    
    var titleView : UILabel = {
        var labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
   
    var movieImageView : UIImageView = {
       var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.addSubview(movieImageView)
        self.addSubview(titleView)
        setViewsAnchors()
    }
    
    func setViewsAnchors() {
        movieImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        movieImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        titleView.leftAnchor.constraint(equalTo: self.movieImageView.rightAnchor).isActive = true
        titleView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let title = title, let image = movieImage {
            titleView.text = title
            movieImageView.image = image
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
