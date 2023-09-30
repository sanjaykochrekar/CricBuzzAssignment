//
//  ViewController.swift
//  CricBuzzMovie
//
//  Created by Sanju on 30/09/23.
//

import UIKit

class ViewController: UIViewController {
    lazy var vm: CBMainVM = CBMainVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
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
        let cell = UITableViewCell()
        cell.textLabel?.text = "abcd"
        return cell
    }
    
}


// MARK: -

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView()
        sectionHeader.backgroundColor = .white
        sectionHeader.tag = section
        
        let titleLabel = UILabel()
        sectionHeader.addSubview(titleLabel)

        titleLabel.text = "Section\(section)"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: sectionHeader.leadingAnchor, constant: 15).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: sectionHeader.centerYAnchor, constant: 0).isActive = true
       
        
        let rightArrow = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
        sectionHeader.addSubview(rightArrow)
        
        rightArrow.image = UIImage(named: "rightArrow")
        rightArrow.translatesAutoresizingMaskIntoConstraints = false
        rightArrow.trailingAnchor.constraint(equalTo: sectionHeader.trailingAnchor, constant: -15).isActive = true
        rightArrow.centerYAnchor.constraint(equalTo: sectionHeader.centerYAnchor, constant: 0).isActive = true
        
        
        
        let lineView = UIImageView()
        sectionHeader.addSubview(lineView)
        
        lineView.backgroundColor = .gray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.trailingAnchor.constraint(equalTo: sectionHeader.trailingAnchor, constant: -15).isActive = true
        lineView.leadingAnchor.constraint(equalTo: sectionHeader.leadingAnchor, constant: 15).isActive = true
        lineView.bottomAnchor.constraint(equalTo: sectionHeader.bottomAnchor, constant: 0).isActive = true
        
        
        return sectionHeader
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }
}
