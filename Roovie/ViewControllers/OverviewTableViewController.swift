//
//  OverviewTableViewController.swift
//  Roovie
//
//  Created by Andreas De Witte on 28/11/17.
//  Copyright © 2017 Andreas De Witte. All rights reserved.
//

import UIKit
import RealmSwift

class OverviewTableViewController: UITableViewController {
    private var index: Int = -1
    private var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let realm = try! Realm();
        /*try! realm.write {
            realm.deleteAll()
        }*/
        if(realm.isEmpty){
            DataRepo()
        }
        
        user = try! Realm().objects(User.self)[0]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (user?.movieCollections.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "overviewCell", for: indexPath)
        
        cell.textLabel?.text = user?.movieCollections[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "showCollectionMovie", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showCollectionMovie"){
            let temp = segue.destination as! CollectionMovieTableViewController
            temp.movieCollection = user?.movieCollections[self.index]
        }
    }
    
    @IBAction func AddCollection(_ sender: Any) {
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New Collection", message: "Enter the name of your new collection", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Collection Name"
        }
        
        // 3. Grab the value from the text field, and add a collection to the list.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            let textField = alert.textFields![0]
            let name = textField.text
            if(name != ""){
                let collection = MovieCollection(name: name!, color: "blue")
                try! Realm().write {
                    self.user?.movieCollections.append(collection)
                }
                self.tableView.reloadData()
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
