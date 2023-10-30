//
//  CBMovieDataModel.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

enum MovieCategoryType: String {
    case genre = "Genre"
    case year = "Year"
    case actors = "Actors"
    case director = "Director"
    case allMovies = "All Movies"
}


// MARK: - CBSectionDataModel
struct CBSectionDataModel {
    var row: [CBListViewCellDataModel] = []
    var title: MovieCategoryType?
    var isExpanded: Bool = false
}

// MARK: - CBCategoryDataModel
struct CBCategoryDataModel: CBListViewCellDataModel {
    var identifier: String = "CBMovieCategoryTVCell"
    var category: String
}


// MARK: - CBPostDataModel
struct CBMovieDataModel: Codable, CBListViewCellDataModel {
    var identifier: String = "CBMovieTypeTVCell"
    
    let title, year, rated, released: String
    let runtime, genre, director, writer: String
    let actors, plot, language, country: String
    let awards: String
    let poster: String
    let ratings: [Rating]
    let metascore, imdbRating, imdbVotes, imdbID: String
    let type: TypeEnum
    let dvd: DVD?
    let boxOffice, production: String?
    let website: DVD?
    let response: Response
    let totalSeasons: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case totalSeasons
    }
}


// MARK: - DVD
enum DVD: String, Codable {
    case nA = "N/A"
    case the28Nov2000 = "28 Nov 2000"
    case the30Jan2007 = "30 Jan 2007"
}


// MARK: - Rating
struct Rating: Codable {
    let source: Source
    let value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}


enum Source: String, Codable {
    case internetMovieDatabase = "Internet Movie Database"
    case metacritic = "Metacritic"
    case rottenTomatoes = "Rotten Tomatoes"
}


enum Response: String, Codable {
    case responseTrue = "True"
}


enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}
