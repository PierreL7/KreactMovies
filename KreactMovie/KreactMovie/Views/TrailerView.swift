//
//  trailerView.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 20/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit
import WebKit

class TrailerView: UIView {
    
    @IBOutlet weak var webView : WKWebView!

    func getTrailer(videoKey: String) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoKey)") else {return}
        DispatchQueue.main.async {
            self.webView.load(URLRequest(url: url))
        }
    }
}
