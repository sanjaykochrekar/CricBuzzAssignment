//
//  AllMovieVC.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/10/23.
//

import UIKit


/// Indicate sorting option
enum Sort: String {
    case name = "Name"
    case year = "Year"
    case rating = "Rating"
}




class MovieListVC: UITableViewController {
    weak var coordinator: MainCoordinator?
    
    lazy var vm = MovieListVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func setInitialData(movieList: [CBMovieDataModel]) {
        vm.movieList = movieList
    }
    
    
    private func initialSetup() {
        addActionButton()
        tableView.register(UINib(nibName: "CBMovieTypeTVCell", bundle: nil), forCellReuseIdentifier: "CBMovieTypeTVCell")
    }
    
    
    private func addActionButton(){
        let menuHandler: UIActionHandler = {[weak self] action in
            if action.title == Sort.name.rawValue {
                self?.setSort(option: .name)
            } else if action.title == Sort.year.rawValue {
                self?.setSort(option: .year)
            } else if action.title == Sort.rating.rawValue {
                self?.setSort(option: .rating)
            }
        }
        
        let barButtonMenu = UIMenu(title: "Sort", children: [
            UIAction(title: NSLocalizedString(Sort.name.rawValue, comment: ""), image:nil, handler: menuHandler),
            UIAction(title: NSLocalizedString(Sort.rating.rawValue, comment: ""), image: nil, handler: menuHandler),
            UIAction(title: NSLocalizedString(Sort.year.rawValue, comment: ""), image: nil, handler: menuHandler)
        ])
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem?.menu = barButtonMenu
    }
    
    
    private func setSort(option: Sort) {
        vm.sortData(option: option)
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
}


// MARK: - TableView DataSourse and delegate method
extension MovieListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.movieList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = vm.movieList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellData.identifier, for: indexPath) as? CBListViewCell
        cell?.populate(cellData, indexPath: indexPath)
        return cell as! UITableViewCell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToDetail(movies: vm.movieList[indexPath.row] )
    }
}
