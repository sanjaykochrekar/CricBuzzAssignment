//
//  MainView.swift
//  CricBuzzMovie
//
//  Created by Sanju on 26/10/23.
//

import UIKit



class MainView: UIView {
    
    var searchBar: UISearchBar!
    var tableView: UITableView!
    var tableviewBottomConstrain: NSLayoutConstraint?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubViews()
    }
    
   
    func createSubViews() {
        self.backgroundColor = .background
        
        searchBar = UISearchBar()
        addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = true
        
        tableView = UITableView()
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableviewBottomConstrain = tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        tableviewBottomConstrain?.isActive = true
    }
    
}
