//
//  MainCoordinator.swift
//  CricBuzzMovie
//
//  Created by Sanju on 26/10/23.
//

import UIKit



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

    
    func navigateToCategory(data: [CBMovieDataModel]?, title: String) {
        let categoryVC = CBCategoryViewController()
        categoryVC.coordinator = self
        if let data {
            categoryVC.title = title
            categoryVC.movieList = data
        }
        self.navigationController.pushViewController(categoryVC, animated: true)
    }
    
    
    func navigateToDetail(movies: CBMovieDataModel) {
        let detailVC = CBMovieDetailViewController()
        detailVC.coordinator = self
        detailVC.movie = movies
        self.navigationController.pushViewController(detailVC, animated: true)
    }
}
