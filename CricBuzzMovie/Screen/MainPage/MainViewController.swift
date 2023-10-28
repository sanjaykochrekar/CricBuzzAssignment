//
//  ViewController.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

import UIKit




class MainViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    private var mainView: MainView!
    private var dismissKeyboardGesture: UITapGestureRecognizer?
    
    lazy var vm: CBMainVM = CBMainVM()
    
    
    override func loadView() {
        super.loadView()
        mainView = MainView(frame: view.frame)
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.searchBar.delegate = self
        registerCell()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    private func registerCell() {
        mainView.tableView.register(UINib(nibName: "CBMovieTypeTVCell", bundle: nil), forCellReuseIdentifier: "CBMovieTypeTVCell")
        mainView.tableView.register(UINib(nibName: "CBMovieCategoryTVCell", bundle: nil), forCellReuseIdentifier: "CBMovieCategoryTVCell")
    }
    
    
    
    @objc func keyboardWillShow(sender: NSNotification) {
        dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        dismissKeyboardGesture?.cancelsTouchesInView = false
        
        view.addGestureRecognizer(dismissKeyboardGesture!)
        
        if let keyboardFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            mainView.tableviewBottomConstrain?.constant = -keyboardHeight
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        if let dismissKeyboardGesture {
            view.removeGestureRecognizer(dismissKeyboardGesture)
        }
        mainView.tableviewBottomConstrain?.constant = 0
    }
    
}


// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
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


// MARK: - UITableViewDelegate Methods
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !vm.isSearching {
            let sectionHeader = UIView()
            sectionHeader.backgroundColor = .background//UIColor.appColor(.background)
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
                self?.mainView.tableView.reloadSections(IndexSet(integer: section), with: .fade)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        vm.isSearching ? 0 : 60.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vm.data[indexPath.section].row[indexPath.row].identifier == "CBMovieCategoryTVCell" {
            
            if let title =  vm.data[indexPath.section].row[indexPath.row] as? CBCategoryDataModel {
                let title = title.category
                let movieList = vm.getMovieListForNextScreen(type: vm.data[indexPath.section].title ?? "", search: title)
                coordinator?.navigateToCategory(data: movieList, title: title)
            }
           
        } else {
            if let movies = vm.data[indexPath.section].row[indexPath.row] as? CBMovieDataModel {
                coordinator?.navigateToDetail(movies: movies )
            }
        }
    }
    
}

// MARK: - UISearchBarDelegate Methods
extension MainViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        vm.isSearching = !vm.searchString.isEmpty
        if !vm.isSearching {
            vm.setData()
        }
        DispatchQueue.main.async { [weak self] in
            self?.mainView.tableView.reloadData()
        }
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        vm.isSearching = !vm.searchString.isEmpty
        if !vm.isSearching {
            vm.setData()
        }
        DispatchQueue.main.async { [weak self] in
            self?.mainView.tableView.reloadData()
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.searchString = searchText
        vm.isSearching = !searchText.isEmpty
        if searchText.isEmpty {
            vm.setData()
        } else {
            vm.searchMovie()
        }
        DispatchQueue.main.async { [weak self] in
            self?.mainView.tableView.reloadData()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        vm.searchString = ""
        vm.isSearching = false
        vm.setData()
        DispatchQueue.main.async { [weak self] in
            self?.mainView.tableView.reloadData()
        }
    }
    
}
