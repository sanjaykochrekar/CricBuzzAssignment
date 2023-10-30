//
//  CBListViewCell.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

import Foundation


/// Should be extended with UITableviewCell
protocol CBListViewCell {
    
    /// populate cell data within the implementation of the method
    /// - parameters:
    ///   - data: data model of type confiming to type CBListViewCellDataModel
    ///   - indexPath: indexPath of the cell can be used to identify cell or handling tap events
    func populate(_ data: CBListViewCellDataModel, indexPath: IndexPath?)
}

extension CBListViewCell {
    
    func populate(_ data: CBListViewCellDataModel, indexPath: IndexPath?) {
        
    }
    
}


/// Should be extended with Data model for UITableViewCell or UICollectionViewCell
protocol CBListViewCellDataModel {
    /// set identifier as UITableViewCell or UICollectionViewCell reuseIdentifier
    var identifier: String { get set }
}
