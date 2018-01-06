//
//  DataRepo.swift
//  Roovie
//
//  Created by Andreas De Witte on 28/11/17.
//  Copyright © 2017 Andreas De Witte. All rights reserved.
//

import Foundation
import RealmSwift

class DataRepo{
    init() {
        /*let m : Movie = Movie(title: "Bambi", ownRating: 5, officialRating: 4.5, description: "Bambi is een bambi, en zijn mama sterft in deze film. Het is heel aandoenlijk, en elke keer opnieuw moet ik ervan huilen. :(", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjyxNkKURL6Pi0Xfzwvf15sKjCfzLqpZ0w4FkBJHb4wtStjS8z")
        
        let m2 : Movie = Movie(title: "Ali G", ownRating: 5, officialRating: 4.5, description: "Ali G is een gangsta. Hij probeert zijn zijn locatie te beschermen tegen de vernietiging. Het is een grappige, humoristische, hilarische comedie. Echt lachen", image: "https://images-na.ssl-images-amazon.com/images/M/MV5BMTgxMTA5YmYtNTE0MC00Mzk1LWJkNTUtZjJiYzBjYjdlYTM4XkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg")
        let m3 : Movie = Movie(title: "Ali B", ownRating: 5, officialRating: 4.5, description: "Ali G is een gangsta. Hij probeert zijn zijn locatie te beschermen tegen de vernietiging. Het is een grappige, humoristische, hilarische comedie. Echt lachen", image: "https://images-na.ssl-images-amazon.com/images/M/MV5BMTgxMTA5YmYtNTE0MC00Mzk1LWJkNTUtZjJiYzBjYjdlYTM4XkEyXkFqcGdeQXVyNTIzOTk5ODM@._V1_SX300.jpg")
        let mc : MovieCollection = MovieCollection(name: "Favorieten", color: "#DEDADA")
        mc.movies.append(m)
        mc.movies.append(m2)
        let user = User(username: "Mark")
        user.movies.append(m)
        user.movies.append(m2)
        user.movies.append(m3)
        user.movieCollections.append(mc)*/
        
        let user = User(username: "Ik heb nog geen mogelijkheid om hier iets mee te doen")
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(user)
        }
    }
}
