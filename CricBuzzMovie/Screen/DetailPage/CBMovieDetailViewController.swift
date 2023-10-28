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

class CBMovieDetailViewController: UITableViewController {
    weak var coordinator: MainCoordinator?
    
    var movie: CBMovieDataModel?
    var slectedRatingAgency = RatingAgency.imbd
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        addActionButton()
        
    }
    
    
    private func registerCell() {
        tableView.register(UINib(nibName: "CBMovieDetailHeaderTVCell", bundle: nil), forCellReuseIdentifier: "CBMovieDetailHeaderTVCell")
        tableView.register(UINib(nibName: "CBMovieDetailRatingTVCell", bundle: nil), forCellReuseIdentifier: "CBMovieDetailRatingTVCell")
        tableView.register(UINib(nibName: "CBMovieDetailAllInfoTVCell", bundle: nil), forCellReuseIdentifier: "CBMovieDetailAllInfoTVCell")
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
            self?.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .fade)
        }
    }
    
}


extension CBMovieDetailViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
