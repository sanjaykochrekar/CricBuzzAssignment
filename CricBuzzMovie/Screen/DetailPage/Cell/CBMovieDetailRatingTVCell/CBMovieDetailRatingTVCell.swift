//
//  CBMovieDetailRatingTVCell.swift
//  CricBuzzMovie
//
//  Created by Sanju on 01/10/23.
//

import UIKit



class CBMovieDetailRatingTVCell: UITableViewCell {
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ratingAgency: UILabel!
    
    
    func populate(year: String = "-", rating: String = "-", agency: String = "") {
        self.year.text = year
        self.rating.text = rating
        self.ratingAgency.text = agency
    }
}
