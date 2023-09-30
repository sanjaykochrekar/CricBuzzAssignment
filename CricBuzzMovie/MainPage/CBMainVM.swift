//
//  CBMainVM.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//


struct CBSectionDataModel {
    let row: [CBListViewCellDataModel] = []
    var title: String?
    let isExpanded: Bool = true
}

class CBMainVM {
    var data: [CBSectionDataModel] = []
    
    
    init() {
        loadData()
    }
    
    
    func loadData() {
        data.append(CBSectionDataModel())
        data.append(CBSectionDataModel())
        data.append(CBSectionDataModel())
    }
}
