//
//  CBMovieDetailViewController.swift
//  CricBuzzMovie
//
//  Created by Sanju on 01/10/23.
//

import UIKit



class CBMovieDetailViewController: UIViewController {
    var movie: CBMovieDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
}


extension CBMovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CBMovieDetailHeaderTVCell", for: indexPath) as! CBMovieDetailHeaderTVCell
        cell.popuplate(image: movie?.poster, movieName: movie?.title ?? "")
        return cell
    }
    
    
}
