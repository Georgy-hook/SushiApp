//
//  CategoryMenuService.swift
//  SushiApp
//
//  Created by Georgy on 21.09.2023.
//

import Foundation

final class CategoryMenuService {
    
    static let shared = CategoryMenuService()
    private init() {}
    
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    private (set) var menu: [MenuList] = []
    
    static let didChangeNotification = Notification.Name(rawValue: "MenuProviderDidChange")
    
    private var isFetching = false
    
    func fetchMenu(with menuID:Int) {
        guard !isFetching else { return }
        isFetching = true
        
        task?.cancel()
        let request = menuURLRequest(with: menuID)
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Result<CategoryMenu, Error>) in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .success(let body):
                guard body.status else { return }
                body.menuList.forEach{ element in
                    self.menu.append(element)
                }
                NotificationCenter.default
                    .post(
                        name: CategoryMenuService.didChangeNotification,
                        object: self,
                        userInfo: ["menuList": menu])
                
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

extension CategoryMenuService{
    private func menuURLRequest(with menuID: Int) -> URLRequest {
        let urlString = "https://vkus-sovet.ru/api/getSubMenu.php?menuID=\(menuID)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
}

