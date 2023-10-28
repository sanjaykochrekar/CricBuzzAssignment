//
//  CBCategoryViewController.swift
//  CricBuzzMovie
//
//  Created by Sanju on 01/10/23.
//

import UIKit



class CBCategoryViewController: UITableViewController {
    weak var coordinator: MainCoordinator?
    var movieList:[CBMovieDataModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CBMovieTypeTVCell", bundle: nil), forCellReuseIdentifier: "CBMovieTypeTVCell")
    }
    
}

extension CBCategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieList[indexPath.row].identifier, for: indexPath) as? CBListViewCell
        cell?.populate(movieList[indexPath.row], indexPath: indexPath)
        return cell as! UITableViewCell
    }
    
}


extension CBCategoryViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToDetail(movies: movieList[indexPath.row])
    }
}
