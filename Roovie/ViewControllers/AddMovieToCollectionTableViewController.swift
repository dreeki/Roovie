//
//  AddMovieToCollectionTableViewController.swift
//  Roovie
//
//  Created by Andreas De Witte on 2/01/18.
//  Copyright © 2018 Andreas De Witte. All rights reserved.
//

import UIKit
import RealmSwift

class AddMovieToCollectionTableViewController: UITableViewController {
    var user: User?
    var collection: MovieCollection?
    var list = List<Movie>()
    var index: Int = -1
    @IBOutlet var moviesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = try! Realm().objects(User.self)[0]
        
        for movie in (user?.movies)! {
            var contains = false
            for m in (collection?.movies)! {
                if movie.title == m.title {
                    contains = true
                }
            }
            if !contains {
                list.append(movie)
            }
        }
        
        
        self.title = "Add To Collection"
        moviesTable.delegate = self
        moviesTable.dataSource = self
        
        let movieCellNib = UINib(nibName: "\(CollectionMovieCellTableViewCell.self)", bundle: nil)
        moviesTable.register(movieCellNib, forCellReuseIdentifier: "collectionMovieCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTable.dequeueReusableCell(withIdentifier: "collectionMovieCell", for: indexPath) as! CollectionMovieCellTableViewCell
        cell.create(_imageName: list[indexPath.row].image, _title: list[indexPath.row].title, _description: list[indexPath.row].movieDescription)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        let realm = try! Realm()
        try! realm.write {
            collection?.movies.append(list[index])
        }
        //normaal moet die via unwind seque, maar dat is hier niet mogelijk vanwege het gebruik van custom cell ipv prototype cell. 
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
