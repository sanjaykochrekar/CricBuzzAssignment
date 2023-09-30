//
//  CBMovieTypeTVCell.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

import UIKit
import SDWebImage

class CBMovieTypeTVCell: UITableViewCell {
    @IBOutlet weak var posterImage: SDAnimatedImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var year: UILabel!
    
    
    
    var itemImage: SDImageCache = SDImageCache()

    override func awakeFromNib() {
        super.awakeFromNib()
        let url = URL(string: "https://picsum.photos/200/300")!

        posterImage.sd_setImage(with: url, placeholderImage: UIImage(named: "default_logo"), options: .transformAnimatedImage, progress: nil, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
