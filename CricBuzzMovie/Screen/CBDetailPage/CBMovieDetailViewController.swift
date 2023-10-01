//
//  CBMovieDetailViewController.swift
//  CricBuzzMovie
//
//  Created by Sanju on 01/10/23.
//

import UIKit

enum RatingAgency: String {
    case imbd = "IMBD"
    case rottenTomatoes = "Rotten Tomatoes"
    case metacritic = "Metacritic"
    case none
}

class CBMovieDetailViewController: UIViewController {
    var movie: CBMovieDataModel?
    var slectedRatingAgency = RatingAgency.imbd
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActionButton()
    }
    
    func addActionButton(){
        let menuHandler: UIActionHandler = { action in
            if action.title == "IMBD" {
                self.slectedRatingAgency = .imbd
            } else if action.title == "Rotten Tomatoes" {
                self.slectedRatingAgency = .rottenTomatoes
            } else {
                self.slectedRatingAgency = .metacritic
            }
            self.setRating()
        }

        let barButtonMenu = UIMenu(title: "Rating Agency", children: [
            UIAction(title: NSLocalizedString("IMBD", comment: ""), image:nil, handler: menuHandler),
            UIAction(title: NSLocalizedString("Rotten Tomatoes", comment: ""), image: nil, handler: menuHandler),
            UIAction(title: NSLocalizedString("Metacritic", comment: ""), image: nil, handler: menuHandler)
        ])

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.menu = barButtonMenu
    }
    
    
    func getRatingRating() -> String {
        switch slectedRatingAgency {
            
        case .imbd:
            return movie?.imdbRating ?? "NA"
        case .rottenTomatoes:
            return "NA"
        case .metacritic:
            return movie?.metascore ?? "NA"
        default:
            return "NA"
        }
    }
    
    func setRating() {
        DispatchQueue.main.async { [weak self] in
            self?.movieTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
        }
    }
    
}


extension CBMovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CBMovieDetailHeaderTVCell", for: indexPath) as! CBMovieDetailHeaderTVCell
            cell.popuplate(image: movie?.poster, movieName: movie?.title ?? "")
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CBMovieDetailRatingTVCell", for: indexPath) as! CBMovieDetailRatingTVCell
            cell.populate(year: movie?.year ?? "-", rating: getRatingRating(), agency: slectedRatingAgency.rawValue)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CBMovieDetailAllInfoTVCell", for: indexPath) as! CBMovieDetailAllInfoTVCell
            cell.populate(language: movie?.language ?? "-", actor: movie?.actors ?? "-", director: movie?.director ?? "-", writer: movie?.writer ?? "", genre: movie?.genre ?? "-", story: movie?.plot ?? "-")
            return cell
            
        }
    }
    
}
