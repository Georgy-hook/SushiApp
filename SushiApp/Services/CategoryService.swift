//
//  CategoryService.swift
//  SushiApp
//
//  Created by Georgy on 21.09.2023.
//

import Foundation

final class CategoryService {
    
    static let shared = CategoryService()
    private init() {}
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    private (set) var categories: [CategoryMenuList] = []
    
    static let didChangeNotification = Notification.Name(rawValue: "CategoryProviderDidChange")
    
    private var isFetching = false
    
    func fetchCategories() {
        guard !isFetching else { return }
        isFetching = true
        
        task?.cancel()
        let request = categoryURLRequest()
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Result<Category, Error>) in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .success(let body):
                guard body.status else { return }
                body.menuList.forEach{ element in
                    self.categories.append(element)
                }
                NotificationCenter.default
                    .post(
                        name: CategoryService.didChangeNotification,
                        object: self,
                        userInfo: ["categoryList": categories])
                
                self.task = nil
            case .failure(let error):
                print(error)
                self.isFetching = false
            }
        }
        
        self.task = task
        task.resume()
    }
}

extension CategoryService{
    private func categoryURLRequest() -> URLRequest {
        let urlString = "https://vkus-sovet.ru/api/getMenu.php"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
}
