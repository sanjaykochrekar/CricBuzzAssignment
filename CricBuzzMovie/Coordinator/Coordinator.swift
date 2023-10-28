//
//  Coordinator.swift
//  CricBuzzMovie
//
//  Created by Sanju on 26/10/23.
//

import UIKit



protocol Coordinator: AnyObject {
    
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    
    func start()
}

