//
//  ViewController.swift
//  KreactMovie
//
//  Created by Pierre Lefebvre on 19/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import UIKit

class LoadingView: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var movieList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = UIColor(red: 105, green: 168, blue: 79)
        
        APIManager._sharedInstance.getCurrentMovies()
        activityIndicator.startAnimating()
        JSONReader._sharedInstance.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "BoxOfficeSegue") {
            if let destVC = segue.destination as? BoxOfficePageViewController {
                destVC.movieList = movieList
            }
        }
    }
}

// Delegate functions
extension LoadingView: MovieDelegate {
    func movieListReceived(list: [Movie]) {
        movieList = list
        //Using sleep so the transition is not happening to fast
        sleep(1)
        // Both functions have to be called from main thread 
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "BoxOfficeSegue", sender: self)
        }
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
