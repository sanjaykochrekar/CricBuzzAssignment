//
//  CBMainVM.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

import Foundation




class CBMainVM {
    private var movieList:[CBPostDataModel] = []
    var data: [CBSectionDataModel] = []
    
    
    init() {
        loadData()
        setData()
    }
    
    
    func loadData() {
        if let url = Bundle.main.url(forResource: "movies", withExtension: "json") {
            do {
                let movieData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                movieList = try decoder.decode([CBPostDataModel].self, from: movieData)
                
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    private func setData() {
        var item = CBSectionDataModel()
        let category1 = CBCategoryDataModel(category: "Drama")
        let category2 = CBCategoryDataModel(category: "Sports")
        let category3 = CBCategoryDataModel(category: "Romance")
        let category4 = CBCategoryDataModel(category: "Action")
        item.row.append(category1)
        item.row.append(category2)
        item.row.append(category3)
        item.row.append(category4)
        data.append(item)
        data.append(item)
        data.append(item)
        data.append(item)
 
        
        
        var itemAll = CBSectionDataModel(title: "All Movies")
        itemAll.row.append(movieList[0])
        itemAll.row.append(movieList[0])
        itemAll.row.append(movieList[0])
        itemAll.row.append(movieList[0])
        data.append(itemAll)
 
        
    }
}
