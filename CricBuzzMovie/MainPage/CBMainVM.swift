//
//  CBMainVM.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

import Foundation




class CBMainVM {
    private var movieList:[CBMovieDataModel] = []
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
                movieList = try decoder.decode([CBMovieDataModel].self, from: movieData)
                
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    
    private func setData() {
        var item = CBSectionDataModel(title: "Genre")
        let category1 = CBCategoryDataModel(category: "Drama")
        let category2 = CBCategoryDataModel(category: "Sports")
        let category3 = CBCategoryDataModel(category: "Romance")
        let category4 = CBCategoryDataModel(category: "Action")
        item.row.append(category1)
        item.row.append(category2)
        item.row.append(category3)
        item.row.append(category4)
        data.append(item)
        
        
        var item2 = CBSectionDataModel(title: "Year")
        let item2c1 = CBCategoryDataModel(category: "2021")
        let item2c2 = CBCategoryDataModel(category: "2022")
        let item2c3 = CBCategoryDataModel(category: "2019")
        let item2c4 = CBCategoryDataModel(category: "2020")
        item2.row.append(item2c1)
        item2.row.append(item2c2)
        item2.row.append(item2c3)
        item2.row.append(item2c4)
        data.append(item2)
        

        
        
        var itemAll = CBSectionDataModel(title: "All Movies")
        itemAll.row.append(movieList[0])
        itemAll.row.append(movieList[0])
        itemAll.row.append(movieList[0])
        itemAll.row.append(movieList[0])
        data.append(itemAll)
    }
    
    
    func toggleSection(_ section: Int) {
        data[section].isExpanded.toggle()
    }
}
