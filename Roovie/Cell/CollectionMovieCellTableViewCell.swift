//
//  CollectionMovieCellTableViewCell.swift
//  Roovie
//
//  Created by Andreas De Witte on 28/12/17.
//  Copyright © 2017 Andreas De Witte. All rights reserved.
//

import UIKit
//Source: https://www.youtube.com/channel/UC-d1NWv5IWtIkfH47ux4dWA
class CollectionMovieCellTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func create(_imageName: String, _title: String, _description: String){
        //movieImageView.image = UIImage(named: _imageName)
        movieImageView.downloadedFrom(link: _imageName)
        movieTitleLabel.text = _title
        movieDescriptionLabel.text = _description
    }
    
}
