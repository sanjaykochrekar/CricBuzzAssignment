//
//  CBMovieCategoryTVCell.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

import UIKit

class CBMovieCategoryTVCell: UITableViewCell {
    @IBOutlet weak var categoryName: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension CBMovieCategoryTVCell: CBListViewCell {
    
    func populate(_ data: CBListViewCellDataModel, indexPath: IndexPath?) {
        if let safeData = data as? CBCategoryDataModel {
            categoryName.text = safeData.category
        }
    }
    
}

