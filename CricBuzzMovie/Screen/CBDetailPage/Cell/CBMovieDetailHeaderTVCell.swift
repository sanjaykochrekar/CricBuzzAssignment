//
//  CBMovieDetailHeaderTVCell.swift
//  CricBuzzMovie
//
//  Created by Sanju on 01/10/23.
//

import UIKit



class CBMovieDetailHeaderTVCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    
    func popuplate(image: String?, movieName: String) {
        if let url = URL(string: image ?? "") {
            posterImage.sd_setImage(with: url, placeholderImage: UIImage(named: "default_logo"), options: .transformAnimatedImage, progress: nil, completed: nil)
        }
        movieTitle.text = movieName
    }
}
