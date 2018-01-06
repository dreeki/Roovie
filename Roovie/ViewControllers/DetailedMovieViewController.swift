//
//  DetailedMovieViewController.swift
//  Roovie
//
//  Created by Andreas De Witte on 28/12/17.
//  Copyright © 2017 Andreas De Witte. All rights reserved.
//

import UIKit
import RealmSwift

class DetailedMovieViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titelInhoud: UILabel!
    @IBOutlet weak var ratingInhoud: UILabel!
    @IBOutlet weak var imbdRatingInhoud: UILabel!
    @IBOutlet weak var descriptionInhoud: UILabel!
    @IBOutlet weak var editRatingSaveButton: UIButton!
    @IBOutlet weak var editRatingTextField: UITextField!

    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.downloadedFrom(link: (movie?.image)!)
        titelInhoud.text = movie?.title
        ratingInhoud.text = String(format:"%.1f", (movie?.ownRating)!)
        imbdRatingInhoud.text = String(format:"%.1f", (movie?.officialRating)!)
        descriptionInhoud.text = movie?.movieDescription
        descriptionInhoud.sizeToFit()
        self.title = movie?.title
    }

    @IBAction func editDetailedMovie(_ sender: Any) {
        self.editRatingTextField.text = String(format:"%.1f", (movie?.ownRating)!)
        self.editRatingTextField.isHidden = false
        self.editRatingSaveButton.isHidden = false
        self.ratingInhoud.isHidden = true
    }
    
    
    @IBAction func saveEdit(_ sender: Any) {
        editRatingTextField.isHidden = true
        editRatingSaveButton.isHidden = true
        ratingInhoud.isHidden = false
        
        if let cost = Double(self.editRatingTextField.text!) {
            try! Realm().write {
                movie?.ownRating = cost
            }
            ratingInhoud.text = String(format:"%.1f", (movie?.ownRating)!)
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
