//
//  MainCoordinator.swift
//  CricBuzzMovie
//
//  Created by Sanju on 26/10/23.
//

import UIKit


/// Main coordinator responsible handling the root navigation of the application
///
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinator = [Coordinator]()
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let mainViewController = MainViewController()
        mainViewController.coordinator = self
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
    
    /// Navigate to movie detail page
    /// - parameters:
    ///  - movies: movie model (CBMovieDataModel)
    func navigateToDetail(movies: CBMovieDataModel) {
        let detailVC = CBMovieDetailViewController()
        detailVC.coordinator = self
        detailVC.movie = movies
        self.navigationController.pushViewController(detailVC, animated: true)
    }
    
    /// Navigate to movie list, displays list of movies
    /// - parameters:
    ///  - movies: list of movies
    ///  - title: displayed on the top of the screen
    func navigateToMoviewList(movies: [CBMovieDataModel], title: String = "") {
        let movieList = MovieListVC()
        movieList.coordinator = self
        movieList.setInitialData(movieList: movies)
        movieList.title = title
        self.navigationController.pushViewController(movieList, animated: true)
    }
}
