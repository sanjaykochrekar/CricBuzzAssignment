//
//  Coordinator.swift
//  CricBuzzMovie
//
//  Created by Sanju on 26/10/23.
//

import UIKit


/// Protocol for should be used to create new Coordinator
protocol Coordinator: AnyObject {
    
    /// use when there is need for nest coordinators
    var childCoordinator: [Coordinator] { get set }
    
    /// UINavigationController for the particular coordinator
    var navigationController: UINavigationController { get set }
    
    /// start method need to be called when coordinator is first created
    /// use start method to set initial view contoller
    func start()
}

