//
//  MovieCollection.swift
//  Roovie
//
//  Created by Andreas De Witte on 28/11/17.
//  Copyright © 2017 Andreas De Witte. All rights reserved.
//

import Foundation
import RealmSwift

class MovieCollection : Object{
    @objc dynamic var id: String = ""
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    let movies = List<Movie>()
    
    convenience init(name : String, color : String, id : String) {
        self.init()
        self.name = name
        self.color = color
        self.id = id
    }
    
    convenience init(name : String, color : String) {
        self.init()
        self.name = name
        self.color = color
        self.id = "0"
    }
}
