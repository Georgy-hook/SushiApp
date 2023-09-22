//
//  TabBarController.swift
//
//
//  Created by Georgy on 26.08.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        self.tabBar.backgroundColor = .black
        self.tabBar.tintColor = .yellow
        self.tabBar.unselectedItemTintColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let viewController = ViewController()
        let nav = UINavigationController(rootViewController: viewController)
        
        viewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "list.bullet"),
            selectedImage: nil
        )
        
        let emptyVC = UIViewController()
            
        emptyVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "bag"),
            selectedImage: nil
        )
        
        let anotherEmptyVC = UIViewController()
            
        anotherEmptyVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "info"),
            selectedImage: nil
        )
        
        self.viewControllers = [nav, emptyVC, anotherEmptyVC]
    }
}
