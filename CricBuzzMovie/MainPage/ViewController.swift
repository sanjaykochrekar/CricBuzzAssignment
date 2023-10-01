//
//  ViewController.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var movieUITableView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    
    lazy var vm: CBMainVM = CBMainVM()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        hideKeyboardWhenTappedAround()
        registerCell()
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    private func registerCell() {
        movieUITableView.register(UINib(nibName: "CBMovieTypeTVCell", bundle: nil), forCellReuseIdentifier: "CBMovieTypeTVCell")
        movieUITableView.register(UINib(nibName: "CBMovieCategoryTVCell", bundle: nil), forCellReuseIdentifier: "CBMovieCategoryTVCell")
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        vm.data.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.data[section].isExpanded ? vm.data[section].row.count : 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = vm.data[indexPath.section].row[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellData.identifier, for: indexPath) as? CBListViewCell
        cell?.populate(cellData, indexPath: indexPath)
        return cell as! UITableViewCell
    }
    
}


// MARK: -

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !vm.isSearching {
            let sectionHeader = UIView()
            sectionHeader.tag = section
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.toggleSection(_:)))
            tap.cancelsTouchesInView = false
            
            sectionHeader.addGestureRecognizer(tap)
            
            let titleLabel = UILabel()
            sectionHeader.addSubview(titleLabel)
            
            titleLabel.text = vm.data[section].title
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.leadingAnchor.constraint(equalTo: sectionHeader.leadingAnchor, constant: 15).isActive = true
            titleLabel.centerYAnchor.constraint(equalTo: sectionHeader.centerYAnchor, constant: 0).isActive = true
            
            
            let rightArrow = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
            sectionHeader.addSubview(rightArrow)
            
            rightArrow.image = UIImage(named: "rightArrow")
            
            
            if !self.vm.data[section].isExpanded  {
                rightArrow.transform = .init(rotationAngle: Double.zero)
            } else {
                rightArrow.transform = .init(rotationAngle: Double.pi / 2)
            }
            
            rightArrow.translatesAutoresizingMaskIntoConstraints = false
            rightArrow.trailingAnchor.constraint(equalTo: sectionHeader.trailingAnchor, constant: -15).isActive = true
            rightArrow.centerYAnchor.constraint(equalTo: sectionHeader.centerYAnchor, constant: 0).isActive = true
            
            
            if !vm.data[section].isExpanded {
                let lineView = UIImageView()
                sectionHeader.addSubview(lineView)
                lineView.backgroundColor = .gray
                lineView.translatesAutoresizingMaskIntoConstraints = false
                lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
                lineView.trailingAnchor.constraint(equalTo: sectionHeader.trailingAnchor, constant: -15).isActive = true
                lineView.leadingAnchor.constraint(equalTo: sectionHeader.leadingAnchor, constant: 15).isActive = true
                lineView.bottomAnchor.constraint(equalTo: sectionHeader.bottomAnchor, constant: 0).isActive = true
            }
            
            
            return sectionHeader
        }
        return nil
    }
    
    @objc func toggleSection(_ sender: UITapGestureRecognizer) {
        if let section = sender.view?.tag {
            vm.toggleSection(section)
            DispatchQueue.main.async { [weak self] in
                self?.movieUITableView.reloadSections(IndexSet(integer: section), with: .fade)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        vm.isSearching ? 0 : 60.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vm.data[indexPath.section].row[indexPath.row].identifier == "CBMovieCategoryTVCell" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let categoryVC = storyboard.instantiateViewController(withIdentifier: "CBCategoryViewController") as! CBCategoryViewController
           
            if let title =  vm.data[indexPath.section].row[indexPath.row] as? CBCategoryDataModel {
                categoryVC.title = title.category
                categoryVC.movieList = vm.getMovieListForNextScreen(type: vm.data[indexPath.section].title ?? "", search: title.category)
            }
            self.navigationController?.pushViewController(categoryVC, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let deatilVC = storyboard.instantiateViewController(withIdentifier: "CBMovieDetailViewController") as! CBMovieDetailViewController
            deatilVC.movie = vm.data[indexPath.section].row[indexPath.row] as? CBMovieDataModel
            self.navigationController?.pushViewController(deatilVC, animated: true)
        }
    }
}


extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        vm.isSearching = !vm.searchString.isEmpty
        if !vm.isSearching {
            vm.setData()
        }
        DispatchQueue.main.async { [weak self] in
            self?.movieUITableView.reloadData()
        }
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        vm.isSearching = !vm.searchString.isEmpty
        if !vm.isSearching {
            vm.setData()
        }
        DispatchQueue.main.async { [weak self] in
            self?.movieUITableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        DispatchQueue.main.async { [weak self] in
//            self?.movieUITableView.reloadData()
//        }
        vm.searchString = searchText
        vm.isSearching = !searchText.isEmpty
        if searchText.isEmpty {
            vm.setData()
        } else {
            vm.searchMovie()
        }
        DispatchQueue.main.async { [weak self] in
            self?.movieUITableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
