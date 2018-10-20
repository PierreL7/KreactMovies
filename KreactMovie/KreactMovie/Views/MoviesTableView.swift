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

class MoviesTableView: UIView {

    @IBOutlet weak var tableView : UITableView!
    var data = [CellData]()
    
    func createTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        data = [CellData.init(movieImage: UIImage(named: "kreactMovieLogo"), title: "Venum"), CellData.init(movieImage: UIImage(named: "kreactMovieLogo"), title: "Venum"), CellData.init(movieImage: UIImage(named: "kreactMovieLogo"), title: "Venum"), CellData.init(movieImage: UIImage(named: "kreactMovieLogo"), title: "Venum")]
        self.tableView.register(MovieCustomCellTableViewCell.self, forCellReuseIdentifier: "movieCell")
        self.tableView.rowHeight = UITableView.automaticDimension   //resize cell to its content
    }
}

//Delegates Functions
extension MoviesTableView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100 // the height you want
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCustomCellTableViewCell
        
        cell.movieImage = data[indexPath.row].movieImage
        cell.title = data[indexPath.row].title
        cell.layoutSubviews()
        if indexPath.row % 2 != 0 {
            cell.backgroundColor = UIColor(red: 105, green: 168, blue: 79).withAlphaComponent(0.7)
        }
        return cell
    }
}
