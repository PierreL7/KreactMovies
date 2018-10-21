//
//  trailerView.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 20/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit
import WebKit

class TrailerView: UIView, WKNavigationDelegate{
    
    @IBOutlet weak var webView : WKWebView!
    @IBOutlet weak var loadingIndicator : UIActivityIndicatorView!


    func getTrailer(videoKey: String) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoKey)") else {return}
        DispatchQueue.main.async {
            self.webView.navigationDelegate = self
            self.webView.load(URLRequest(url: url))
        }
    }
    
    func webView(_: WKWebView, didStartProvisionalNavigation: WKNavigation!) {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func webView(_: WKWebView, didFinish: WKNavigation!) {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }
    
    func webView(_: WKWebView, didFail: WKNavigation!, withError: Error) {
        print("VIDEO NOT FOUND")
    }
}
