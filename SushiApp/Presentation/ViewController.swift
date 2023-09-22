//
//  ViewController.swift
//  SushiApp
//
//  Created by Georgy on 20.09.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - UI Elements
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vkussovetLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    //MARK: - Variables
    let categoryService = CategoryService.shared
    let categoryMenuService = CategoryMenuService.shared
    private var categoryServiceObserver: NSObjectProtocol?
    private var categoryMenuServiceObserver: NSObjectProtocol?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubviews()
        applyConstraints()
        addObserverToCategory()
        addObserverToMenu()
        
        categoryService.fetchCategories()
        categoryMenuService.fetchMenu(with: 23)
    }
}

//MARK: - Layout
extension ViewController{
    private func configureUI(){
        view.backgroundColor = UIColor(named: "Sh Background")
        
        setupNavBar()  
    }
    
    private func addSubviews(){
        
    }
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func setupNavBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let logoImage = UIBarButtonItem(customView: logoImageView)
        navigationItem.leftBarButtonItem = logoImage
        
        let phoneBtn = UIButton(type: .custom)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)
        phoneBtn.setImage(UIImage(systemName: "phone", withConfiguration: largeConfig), for: .normal)
        phoneBtn.tintColor = .white
        
        let phoneBarItem = UIBarButtonItem(customView: phoneBtn)
        
        navigationItem.rightBarButtonItem = phoneBarItem
    }
}

//MARK: - Notification center
extension ViewController{
    private func addObserverToCategory(){
        categoryServiceObserver = NotificationCenter.default
            .addObserver(
                forName: CategoryService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                print(categoryService.categories)
                
            }
        print(categoryService.categories)
    }
    
    private func addObserverToMenu(){
        categoryMenuServiceObserver = NotificationCenter.default
            .addObserver(
                forName: CategoryMenuService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                print(categoryMenuService.menu)
                
            }
        print(categoryMenuService.menu)
    }
}

