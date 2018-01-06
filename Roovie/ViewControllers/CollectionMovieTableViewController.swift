//
//  CollectionMovieTableViewController.swift
//  Roovie
//
//  Created by Andreas De Witte on 28/12/17.
//  Copyright © 2017 Andreas De Witte. All rights reserved.
//

import UIKit
class CollectionMovieTableViewController: UITableViewController {
    @IBOutlet var moviesTable: UITableView!
    var index: Int = -1

    var movieCollection : MovieCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = movieCollection?.name
        moviesTable.delegate = self
        moviesTable.dataSource = self
        
        let movieCellNib = UINib(nibName: "\(CollectionMovieCellTableViewCell.self)", bundle: nil)
        moviesTable.register(movieCellNib, forCellReuseIdentifier: "collectionMovieCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (movieCollection?.movies.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTable.dequeueReusableCell(withIdentifier: "collectionMovieCell", for: indexPath) as! CollectionMovieCellTableViewCell
        cell.create(_imageName: (movieCollection?.movies[indexPath.row].image)!, _title: (movieCollection?.movies[indexPath.row].title)!, _description: (movieCollection?.movies[indexPath.row].movieDescription)!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "showMovieDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showMovieDetailSegue"){
            let temp = segue.destination as! DetailedMovieViewController
            temp.movie = movieCollection?.movies[index]
        }
        if(segue.identifier == "addMovieToCollectionSeque"){
            let temp = segue.destination as! AddMovieToCollectionTableViewController
            temp.collection = movieCollection
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
