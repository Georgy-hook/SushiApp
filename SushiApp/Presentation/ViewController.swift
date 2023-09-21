//
//  ViewController.swift
//  SushiApp
//
//  Created by Georgy on 20.09.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - UI Elements
    
    //MARK: - Variables
    let categoryService = CategoryService.shared
    private var categoryServiceObserver: NSObjectProtocol?
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubviews()
        applyConstraints()
        addObserverToCategory()
        
        categoryService.fetchCharacters()
    }
}

//MARK: - Layout
extension ViewController{
    private func configureUI(){
        
    }
    
    private func addSubviews(){
        
    }
    
    private func applyConstraints(){
        NSLayoutConstraint.activate([
            
        ])
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
}

