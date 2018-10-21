//
//  KreactMovieTests.swift
//  KreactMovieTests
//
//  Created by Pierre Lefebvre on 19/10/2018.
//  Copyright © 2018 Pierre Lefebvre. All rights reserved.
//

import XCTest
@testable import KreactMovie

class KreactMovieTests: XCTestCase {
    
    func testGetData(){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w45/kqjL17yufvn9OVLyXYpvtyrFfak.jpg") else {return}
        APIManager._sharedInstance.getData(from: url) { data, response, error in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
        }
    }
}
