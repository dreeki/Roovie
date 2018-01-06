//
//  Movie.swift
//  Roovie
//
//  Created by Andreas De Witte on 28/11/17.
//  Copyright © 2017 Andreas De Witte. All rights reserved.
//

import Foundation
import RealmSwift

class Movie : Object{
    @objc dynamic var id: String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var ownRating : Double = 0
    @objc dynamic var officialRating : Double = 0
    @objc dynamic var movieDescription : String = ""
    @objc dynamic var image : String = ""
    
    convenience init(title : String, ownRating : Double, officialRating : Double, description : String, image : String, id : String) {
        self.init()
        self.title = title
        self.ownRating = ownRating
        self.officialRating = officialRating
        self.movieDescription = description
        self.image = image
        self.id = id
    }
    
    convenience init(title : String, ownRating : Double, officialRating : Double, description : String, image : String) {
        self.init()
        self.title = title
        self.ownRating = ownRating
        self.officialRating = officialRating
        self.movieDescription = description
        self.image = image
        self.id = "0"
    }
}
