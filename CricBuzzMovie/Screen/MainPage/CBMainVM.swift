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
    var isSearching = false
    var searchString = ""
    
    
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
    
    
    func searchMovie() {
        data.removeAll()
        data.append(searchMovie(searchString))
    }
    
    
    func setData() {
        data.removeAll()
        data.append(getGenre())
        data.append(getYear())
        data.append(getActors())
        data.append(getDirectors())
        data.append(getAllMovies())
    }
    
    
    func toggleSection(_ section: Int) {
        data[section].isExpanded.toggle()
    }
    
}



// MARK: - Filter Functions
extension CBMainVM {
    
    func getGenre() -> CBSectionDataModel {
        var genreList = Set<String>()
        for (_, item) in movieList.enumerated() {
            let stringList = item.genre.components(separatedBy: ",")
            let cleanlist = stringList.map {$0.trimmingCharacters(in: .whitespaces)}
            genreList.formUnion(cleanlist)
        }
        
        var genre = CBSectionDataModel(title: .genre)
        for (_, item ) in genreList.sorted().enumerated() {
            genre.row.append(CBCategoryDataModel(category: item))
        }
        return genre
    }
    
    
    func getYear() -> CBSectionDataModel {
        var yearList = Set<String>()
        let formatter = DateFormatter()
        
        for (_, item) in movieList.enumerated() {
            formatter.dateFormat = "dd MMM yyyy"
            
            if let date = formatter.date(from: item.released) {
                formatter.dateFormat = "yyyy"
                yearList.insert(formatter.string(from: date))
            }
        }
        
        var year = CBSectionDataModel(title: .year)
        
        for (_, item ) in yearList.sorted().enumerated() {
            year.row.append(CBCategoryDataModel(category: item))
        }
       
        return year
    }
    
    
    func getActors() -> CBSectionDataModel {
        var genreList = Set<String>()
        
        for (_, item) in movieList.enumerated() {
            let stringList = item.actors.components(separatedBy: ",")
            let cleanlist = stringList.map {$0.trimmingCharacters(in: .whitespaces)}
            genreList.formUnion(cleanlist)
        }
        
        var genre = CBSectionDataModel(title: .actors)
        for (_, item ) in genreList.sorted().enumerated() {
            genre.row.append(CBCategoryDataModel(category: item))
        }
        return genre
    }
    
    
    func getDirectors() -> CBSectionDataModel {
        var genreList = Set<String>()
        
        for (_, item) in movieList.enumerated() {
            let stringList = item.director.components(separatedBy: ",")
            let cleanlist = stringList.map {$0.trimmingCharacters(in: .whitespaces)}
            genreList.formUnion(cleanlist)
        }
        
        var genre = CBSectionDataModel(title: .director)
        for (_, item ) in genreList.sorted().enumerated() {
            genre.row.append(CBCategoryDataModel(category: item))
        }
        return genre
    }
    
    
    func getAllMovies() -> CBSectionDataModel {
        var allItems = CBSectionDataModel(title: .allMovies)
        allItems.row.append(contentsOf: movieList)
        return allItems
    }
    
    
    private func searchMovie(_ search: String) -> CBSectionDataModel {
        var allItems = CBSectionDataModel()
        allItems.isExpanded = true
        allItems.row.append(contentsOf: movieList.filter({ item in
            let titleMatch = item.title.containsIgnoringCase(find: search)
            
            return false || titleMatch
        }))
        return allItems
    }
}


// MARK: - Next Screen query
extension CBMainVM {
    
    func getMovieListForNextScreen(type: MovieCategoryType, search: String) -> [CBMovieDataModel] {
        switch type {
        case .genre:
            return getOnlyGenre(genre: search)
        case .year:
            return getOnlyYear(year: search)
        case .actors:
            return getOnlyActor(actor: search)
        case .director:
            return getOnlyDirector(director: search)
        case .allMovies:
            return movieList
        }
    }
    
    
    func getAllMovies() -> [CBMovieDataModel] {
        movieList
    }
    
    
    private func getOnlyGenre(genre: String) -> [CBMovieDataModel] {
        movieList.filter { item in
            item.genre.containsIgnoringCase(find: genre)
        }
    }
    
    
    private func getOnlyYear(year: String) -> [CBMovieDataModel] {
        movieList.filter { item in
            item.released.containsIgnoringCase(find: year)
        }
    }
     
    
    private func getOnlyActor(actor: String) -> [CBMovieDataModel] {
        movieList.filter { item in
            item.actors.containsIgnoringCase(find: actor)
        }
    }
    
    
    private func getOnlyDirector(director: String) -> [CBMovieDataModel] {
        movieList.filter { item in
            item.director.containsIgnoringCase(find: director)
        }
    }
    
}
