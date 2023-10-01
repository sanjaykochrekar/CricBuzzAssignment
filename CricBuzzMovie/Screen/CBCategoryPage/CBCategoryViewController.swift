//
//  CBCategoryViewController.swift
//  CricBuzzMovie
//
//  Created by Sanju on 01/10/23.
//

import UIKit



class CBCategoryViewController: UIViewController {
    var movieList:[CBMovieDataModel] = []
    
    @IBOutlet weak var movieUITableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieUITableView.register(UINib(nibName: "CBMovieTypeTVCell", bundle: nil), forCellReuseIdentifier: "CBMovieTypeTVCell")
    }
    
}

extension CBCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieList[indexPath.row].identifier, for: indexPath) as? CBListViewCell
        cell?.populate(movieList[indexPath.row], indexPath: indexPath)
        return cell as! UITableViewCell
    }
    
    
}