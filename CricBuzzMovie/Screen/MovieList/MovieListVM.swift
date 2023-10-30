//
//  MovieListVM.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/10/23.
//

import Foundation


class MovieListVM {
    var movieList:[CBMovieDataModel] = []
    var sort: Sort = .name
    
    func sortData(option: Sort) {
        movieList = movieList.sorted(by: { item1, item2 in
            if option == .name {
                return item1.title < item2.title
            } else if option == .year {
                return item1.year < item2.year
            } else if option == .rating {
                return item1.imdbRating < item2.imdbRating
            }
            return false
        })
    }
    
}
