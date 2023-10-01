//
//  String+Extension.swift
//  CricBuzzMovie
//
//  Created by Sanju on 01/10/23.
//

import Foundation

extension String {
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
}

