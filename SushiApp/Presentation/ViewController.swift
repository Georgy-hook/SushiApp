//
//  ViewController.swift
//  SushiApp
//
//  Created by Georgy on 20.09.2023.
//

import UIKit

protocol ViewControllerProtocol:AnyObject{
    func fetchMenu(with menuID:Int)
}

final class ViewController: UIViewController {
    
    //MARK: - UI Elements
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vkussovetLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    let categoryCollectionView = CategoryCollectionView()
    let categoryMenuCollectionView = CategoryMenuCollectionView()
    
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
    }
}

//MARK: - Layout
extension ViewController{
    private func configureUI(){
        view.backgroundColor = UIColor(named: "Sh Background")
        
        setupNavBar()  
        
        categoryCollectionView.delegateVC = self
    }
    
    private func addSubviews(){
        view.addSubview(categoryCollectionView)
        view.addSubview(categoryMenuCollectionView)
    }
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 160),
            
            categoryMenuCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            categoryMenuCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            categoryMenuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryMenuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupNavBar(){
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
                categoryCollectionView.set(with: categoryService.categories)
                categoryCollectionView.initialSelect()
                
            }
        categoryCollectionView.set(with: categoryService.categories)
        
    }
    
    private func addObserverToMenu(){
        categoryMenuServiceObserver = NotificationCenter.default
            .addObserver(
                forName: CategoryMenuService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                categoryMenuCollectionView.set(with: categoryMenuService.menu, and: categoryCollectionView.title)
                
            }
        categoryMenuCollectionView.set(with: categoryMenuService.menu, and: categoryCollectionView.title)
    }
}

//MARK: - ViewControllerProtocol
extension ViewController:ViewControllerProtocol{
    func fetchMenu(with menuID: Int) {
        categoryMenuService.fetchMenu(with: menuID)
    }
}
