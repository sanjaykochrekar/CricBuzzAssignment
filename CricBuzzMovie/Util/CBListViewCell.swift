//
//  CBListViewCell.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

import Foundation


protocol CBListViewCell {
    func populate(_ data: CBListViewCellDataModel, indexPath: IndexPath?)
}

extension CBListViewCell {
    
    func populate(_ data: CBListViewCellDataModel, indexPath: IndexPath?) {
        
    }
    
}



protocol CBListViewCellDataModel {
    var identifier: String { get set }
}
