//
//  searchBarView.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 19/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

class SearchBarView: UIView {

    @IBOutlet weak var searchBar : UISearchBar!
    
    func removeSearchBarBackground() {
        searchBar.backgroundImage = UIImage()
    }
}
