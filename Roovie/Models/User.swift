//
//  User.swift
//  Roovie
//
//  Created by Andreas De Witte on 28/11/17.
//  Copyright © 2017 Andreas De Witte. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object{
    @objc dynamic var username : String = ""
    let movieCollections = List<MovieCollection>()
    let movies = List<Movie>()
    
    convenience init(username : String){
        self.init()
        self.username = username
    }
}
