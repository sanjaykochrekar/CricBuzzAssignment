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
        item.row.append(movieList[0])
        item.row.append(movieList[0])
        item.row.append(movieList[0])
        item.row.append(movieList[0])
        data.append(item)
        data.append(item)
        data.append(item)
    }
}
