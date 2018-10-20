//
//  SynopsisView.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 20/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

class SynopsisView: UIView {

    @IBOutlet weak var synopsisLabel : UILabel!
    
    func setSynopsis(synopsis: String) {
        synopsisLabel.text = synopsis
    }
}
