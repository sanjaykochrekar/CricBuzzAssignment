//
//  CBMovieTypeSectionHeader.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

import UIKit

class CBMovieTypeSectionHeader: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("CBMovieTypeSectionHeader", owner: self, options: nil)
    }
}
