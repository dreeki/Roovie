//
//  AllMoviesTableViewController.swift
//  Roovie
//
//  Created by Andreas De Witte on 2/01/18.
//  Copyright © 2018 Andreas De Witte. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class AllMoviesTableViewController: UITableViewController {
    var user: User?
    var index: Int = -1
    @IBOutlet var moviesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = try! Realm().objects(User.self)[0]
        
        self.title = "My Movies"
        moviesTable.delegate = self
        moviesTable.dataSource = self
        
        let movieCellNib = UINib(nibName: "\(CollectionMovieCellTableViewCell.self)", bundle: nil)
        moviesTable.register(movieCellNib, forCellReuseIdentifier: "collectionMovieCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (user?.movies.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTable.dequeueReusableCell(withIdentifier: "collectionMovieCell", for: indexPath) as! CollectionMovieCellTableViewCell
        cell.create(_imageName: (user?.movies[indexPath.row].image)!, _title: (user?.movies[indexPath.row].title)!, _description: (user?.movies[indexPath.row].movieDescription)!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "showMovieDetailSegue2", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showMovieDetailSegue2"){
            let temp = segue.destination as! DetailedMovieViewController2
            temp.movie = user?.movies[index]
        }
    }

    @IBAction func addMovie(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New Movie", message: "Enter the title of the movie, don't make typo's tho!", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Movie Title"
        }
        
        // 3. Grab the value from the text field, and add a collection to the list.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            let textField = alert.textFields![0]
            let title = textField.text
            if(title != ""){
                //do API call
                let apiString = ("https://www.omdbapi.com/?apikey=49cce24e&&t=" + title!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                Alamofire.request(apiString!).responseJSON(completionHandler: { (response) in
                    print(response.response?.statusCode)
                    if response.response?.statusCode == 200{
                        if let result = response.result.value{
                            let JSON = result as! NSDictionary
                            if let _ = JSON["Title"] {
                                let title = JSON.object(forKey: "Title") as! String
                                let desc = JSON.object(forKey: "Plot") as! String
                                let image = JSON.object(forKey: "Poster") as! String
                                let s = JSON.object(forKey: "imdbRating") as! String
                                let score = Double(s)
                                try! Realm().write {
                                    var movie = Movie(title: title, ownRating: 0, officialRating: score!, description: desc, image: image)
                                    self.user?.movies.append(movie)
                                }
                                self.tableView.reloadData()
                            }
                        }else {
                            let alert2 = UIAlertController(title: "Movie not found", message: "We could not find the title you entered", preferredStyle: .alert)
                            
                            alert2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                                
                            }))
                        }
                    }
                })
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
