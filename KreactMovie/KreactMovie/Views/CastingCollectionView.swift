//
//  CastingCollectionView.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 21/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

class CastingCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var actors = [Actor]()
    
    func createCastingView(_actors: [Actor]) {
        self.dataSource = self
        self.delegate = self
        actors = _actors
        actors.forEach { (actor) in
            APIManager._sharedInstance.downloadPicture(from: actor.picturePath ?? "unknown", with: "w185", with: actor)
        }
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "CastingCell", for: indexPath) as! CastingCollectionViewCell
        
        cell.actorPicture.image = actors[indexPath.row].Picture
        cell.actorName.text = actors[indexPath.row].Name
        cell.characterName.text = actors[indexPath.row].Character
        
        return cell
    }
}
