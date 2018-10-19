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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarView.removeSearchBarBackground()
        moviesTableView.createTableView()
    }
}
